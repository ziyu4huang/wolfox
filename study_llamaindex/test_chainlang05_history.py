# https://myapollo.com.tw/blog/langchain-tutorial-retrieval/
from langchain.chains.combine_documents import create_stuff_documents_chain
from langchain.chains import create_retrieval_chain
from langchain.chains import create_history_aware_retriever
from langchain_core.messages import HumanMessage, AIMessage
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.prompts import MessagesPlaceholder
from langchain_community.llms import Ollama
from langchain_community.embeddings import OllamaEmbeddings
from langchain_community.vectorstores import FAISS

import logging

# Configure logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

from langchain.callbacks.base import BaseCallbackHandler

class LoggingCallback(BaseCallbackHandler):
    def on_llm_start(self, serialized, prompts, **kwargs):
        logger.debug(f"LLM input: {prompts}")

    def on_llm_end(self, response, **kwargs):
        logger.debug(f"LLM output: {response}")
# Add the custom callback
callbacks = [LoggingCallback()]


llm = Ollama(model='llama3.1', callbacks=callbacks)
embeddings = OllamaEmbeddings(model='llama3.1')

vector = FAISS.from_texts(['My name is Amo.'], embeddings)
retriever = vector.as_retriever()

prompt = ChatPromptTemplate.from_messages([
    ('system', 'Answer the user\'s questions based on the below context:\n\n{context}'),
    ('user', '{input}'),
])
document_chain = create_stuff_documents_chain(llm, prompt)

prompt = ChatPromptTemplate.from_messages([
    MessagesPlaceholder(variable_name="chat_history"),
    ("user", "{input}"),
    ("user", "Given the above conversation, generate a search query to look up in order to get information relevant to the conversation {chat_history}")
])


retriever_chain = create_history_aware_retriever(llm, retriever, prompt)
retrieval_chain = create_retrieval_chain(retriever_chain, document_chain)
# Create a chain with the LLM and pass the callback


chat_history = []
input_text = input('>>> ')
while input_text.lower() != 'bye':
    if input_text:
        response = retrieval_chain.invoke({
            'input': input_text,
            'context': chat_history,
            'chat_history': chat_history,
        })
        print(response['answer'])
        chat_history.append(HumanMessage(content=input_text))
        chat_history.append(AIMessage(content=response['answer']))
    input_text = input('>>> ')

