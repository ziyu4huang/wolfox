#pypdf


#https://github.com/TanAlex/langchain-ollama-chainlit/blob/main/main.py
# import required dependencies
# https://docs.chainlit.io/integrations/langchain
import os
from langchain import hub
from langchain_community.embeddings import OllamaEmbeddings
#from langchain_community.vectorstores import Chroma
from langchain_chroma import Chroma

from langchain_community.llms import Ollama
from langchain.callbacks.manager import CallbackManager
from langchain.callbacks.streaming_stdout import StreamingStdOutCallbackHandler
import chainlit as cl
from langchain.chains import RetrievalQA
import pickle

ABS_PATH: str = os.path.dirname(os.path.abspath(__file__))
DB_DIR: str = os.path.join(ABS_PATH, "db")


file_name = os.path.splitext(os.path.basename(__file__))[0]

# Set up RetrievelQA model
if os.path.isfile(file_name + '.prompt.pickle'):
    print("restore prompt", )
    with open(file_name + '.prompt.pickle', "rb") as file:
        rag_prompt_mistral = pickle.load(file)
    print(rag_prompt_mistral)
    print(type(rag_prompt_mistral))
else:
    #https://docs.smith.langchain.com/how_to_guides/prompts/pull_push_a_prompt#pull-a-prompt-and-use-it
    print("pull prompt")
    rag_prompt_mistral = hub.pull("rlm/rag-prompt-mistral")
    print(rag_prompt_mistral)
    print(type(rag_prompt_mistral))
    with open(file_name+'.prompt.pickle', "wb") as file:
        pickle.dump(rag_prompt_mistral, file)
    #print("down load rag_prompt_mistral", rag_prompt_mistral)

ollama_model = "mistral"
def load_model():
    llm = Ollama(
        model=ollama_model,
        verbose=True,
        callback_manager=CallbackManager([StreamingStdOutCallbackHandler()]),
    )
    return llm


def retrieval_qa_chain(llm, vectorstore):
    qa_chain = RetrievalQA.from_chain_type(
        llm,
        retriever=vectorstore.as_retriever(),
        chain_type_kwargs={"prompt": rag_prompt_mistral},
        return_source_documents=True,
    )
    return qa_chain


def qa_bot():
    llm = load_model()
    DB_PATH = DB_DIR
    vectorstore = Chroma(
        persist_directory=DB_PATH, embedding_function=OllamaEmbeddings(model=ollama_model)
    )

    qa = retrieval_qa_chain(llm, vectorstore)
    return qa


@cl.on_chat_start
async def start():
    """
    Initializes the bot when a new chat starts.

    This asynchronous function creates a new instance of the retrieval QA bot,
    sends a welcome message, and stores the bot instance in the user's session.
    """
    chain = qa_bot()
    welcome_message = cl.Message(content="Starting the bot...")
    await welcome_message.send()
    welcome_message.content = (
        f"Hi, Welcome to Chat With Documents using Ollama ({ollama_model} model) and LangChain."
    )
    await welcome_message.update()
    cl.user_session.set("chain", chain)


@cl.on_message
async def main(message):
    """
    Processes incoming chat messages.

    This asynchronous function retrieves the QA bot instance from the user's session,
    sets up a callback handler for the bot's response, and executes the bot's
    call method with the given message and callback. The bot's answer and source
    documents are then extracted from the response.
    """
    chain = cl.user_session.get("chain")
    cb = cl.AsyncLangchainCallbackHandler()
    cb.answer_reached = True
    res = await chain.ainvoke(message, callbacks=[cb])
    #print(f"response: {res}")
    answer = res["result"]
    #answer = answer.replace(".", ".\n")
    source_documents = res["source_documents"]

    text_elements = []  # type: List[cl.Text]

    if source_documents:
        for source_idx, source_doc in enumerate(source_documents):
            source_name = f"source_{source_idx}"
            # Create the text element referenced in the message
            text_elements.append(
                cl.Text(content=source_doc.page_content, name=source_name)
            )
        source_names = [text_el.name for text_el in text_elements]

        if source_names:
            answer += f"\nSources: {', '.join(source_names)}"
        else:
            answer += "\nNo sources found"

    await cl.Message(content=answer, elements=text_elements).send()

