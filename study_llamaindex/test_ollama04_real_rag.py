# git push --set-upstream origin ollama_study
# https://docs.llamaindex.ai/en/stable/getting_started/starter_example_local/


def main(): 
    from llama_index.core import VectorStoreIndex, SimpleDirectoryReader, Settings
    from llama_index.llms.ollama import Ollama

    #documents = SimpleDirectoryReader("TCRcom", recursive=True).load_data(num_workers=4)
    documents = SimpleDirectoryReader("data_rag", recursive=True).load_data(num_workers=4)

    # bge-base embedding model
    #from llama_index.embeddings.huggingface import HuggingFaceEmbedding
    #Settings.embed_model = HuggingFaceEmbedding(model_name="BAAI/bge-base-en-v1.5")
    # replace with ollama
    # https://docs.llamaindex.ai/en/stable/examples/embeddings/ollama_embedding/
    # %pip install llama-index-embeddings-ollama
    from llama_index.embeddings.ollama import OllamaEmbedding
    Settings.embed_model = OllamaEmbedding(
        model_name="mxbai-embed-1024",
        base_url="http://localhost:11434",
        #ollama_additional_kwargs={"mirostat": 0},
    )


    # ollama
    Settings.llm = Ollama(model="llama3.1", request_timeout=360.0)

    index = VectorStoreIndex.from_documents(
        documents,
    )

    query_engine = index.as_query_engine()
    q = "how to use get_db command , show it's syntax"
    response = query_engine.query(q)
    print(q)
    print(response)

    query_engine = index.as_query_engine()
    q = "show me some example use get_db"
    response = query_engine.query(q)
    print(q)
    print(response)

    query_engine = index.as_query_engine()
    q = "list of know option of get_db command"
    response = query_engine.query(q)
    print(q)
    print(response)

if __name__ == '__main__':
    main()

