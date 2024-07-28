#chromadb
# pip install llama-index-vector-stores-chroma
# pip install llama-index chromadb --quiet
# download file 
# mkdir -p data/paul_graham/
# wget 'https://raw.githubusercontent.com/run-llama/llama_index/main/docs/docs/examples/data/paul_graham/paul_graham_essay.txt' -O 'data/paul_graham/paul_graham_essay.txt'


# Persistent to file
import os
from llama_index.core import VectorStoreIndex, SimpleDirectoryReader
from llama_index.vector_stores.chroma import ChromaVectorStore
from llama_index.core import StorageContext
#from llama_index.embeddings.huggingface import HuggingFaceEmbedding
from llama_index.embeddings.ollama import OllamaEmbedding
from llama_index.llms.ollama import Ollama
from llama_index.core import Settings
#from IPython.display import Markdown, display
import chromadb

chroma_db_path = "./chroma_db_TCRcom"
chroma_col_name = "TCRcom.pdf"

def build_db(documents, embed_model):
    if os.path.isdir(chroma_db_path):
        print("Skip build db")
        return
    print("Start build db ")
    db = chromadb.PersistentClient(path=chroma_db_path)
    chroma_collection = db.get_or_create_collection(chroma_col_name)
    vector_store = ChromaVectorStore(chroma_collection=chroma_collection)
    storage_context = StorageContext.from_defaults(vector_store=vector_store)
    index = VectorStoreIndex.from_documents(
        documents, storage_context=storage_context, embed_model=embed_model
    )
    return index


def load_db(embed_model):
    # load from disk
    db = chromadb.PersistentClient(path=chroma_db_path)
    chroma_collection = db.get_or_create_collection(chroma_col_name)
    vector_store = ChromaVectorStore(chroma_collection=chroma_collection)
    index = VectorStoreIndex.from_vector_store(
        vector_store,
        embed_model=embed_model,
    )
    return index


def main():
    # LLM: ollama
    Settings.llm = Ollama(model="llama3.1", request_timeout=360.0)

    # load documents
    documents = SimpleDirectoryReader("./data_TCRcom/", recursive=True).load_data()

    # define embedding function
    Settings.embed_model = embed_model = OllamaEmbedding(
        model_name="mxbai-embed-1024",
        base_url="http://localhost:11434",
    )

    # create client and a new collection
    build_db(documents, embed_model)
    index = load_db(embed_model)

    # Query Data
    query_engine = index.as_query_engine()
    response = query_engine.query("show me TCL command `get_db` synax and usage")
    print(response)


if __name__ == '__main__':
    main()

