#https://myapollo.com.tw/blog/langchain-tutorial-retrieval/
from langchain_community.llms import Ollama
from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import ChatPromptTemplate

class MyOutputParser(StrOutputParser):
    def parse(self, text):
        return text.replace('Assistant: ', '').strip()

output_parser = MyOutputParser()

llm = Ollama(model='llama3.1')
prompt = ChatPromptTemplate.from_messages([
    ('user', '{input}'),
])

chain = prompt | llm | output_parser

input_text = input('>>> ')
while input_text.lower() != 'bye':
   print(chain.invoke({'input': input_text}))
   input_text = input('>>> ')

