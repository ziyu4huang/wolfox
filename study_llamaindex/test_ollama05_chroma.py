#chromadb
# pip install llama-index-vector-stores-chroma
# pip install llama-index chromadb --quiet
# download file 
# mkdir -p data/paul_graham/
# wget 'https://raw.githubusercontent.com/run-llama/llama_index/main/docs/docs/examples/data/paul_graham/paul_graham_essay.txt' -O 'data/paul_graham/paul_graham_essay.txt'

# import
from llama_index.core import VectorStoreIndex, SimpleDirectoryReader
from llama_index.vector_stores.chroma import ChromaVectorStore
from llama_index.core import StorageContext
#from llama_index.embeddings.huggingface import HuggingFaceEmbedding
from llama_index.embeddings.ollama import OllamaEmbedding
from llama_index.llms.ollama import Ollama
from llama_index.core import Settings
#from IPython.display import Markdown, display
import chromadb

def main():
    # LLM: ollama
    Settings.llm = Ollama(model="llama3.1", request_timeout=360.0)

    # create client and a new collection
    chroma_client = chromadb.EphemeralClient()
    chroma_collection = chroma_client.create_collection("quickstart")

    # define embedding function
    #embed_model = HuggingFaceEmbedding(model_name="BAAI/bge-base-en-v1.5")
    embed_model = OllamaEmbedding(
        model_name="mxbai-embed-1024",
        base_url="http://localhost:11434",
    )

    # load documents
    documents = SimpleDirectoryReader("./data/paul_graham/").load_data()

    # set up ChromaVectorStore and load in data
    vector_store = ChromaVectorStore(chroma_collection=chroma_collection)
    storage_context = StorageContext.from_defaults(vector_store=vector_store)
    index = VectorStoreIndex.from_documents(
        documents, storage_context=storage_context, embed_model=embed_model
    )

    # Query Data
    query_engine = index.as_query_engine()
    response = query_engine.query("What did the author do growing up?")
    #display(Markdown(f"{response}"))
    print(response)

if __name__ == '__main__':
    main()

