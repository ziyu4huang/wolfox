from llama_index.llms.ollama import Ollama

llm = Ollama(model="llama3.1", request_timeout=120.0)

resp = llm.complete("Who is Paul Graham?")

print(resp)
resp = llm.complete("Where is Taipei?")

print(resp)

llm = Ollama(model="llama3", request_timeout=120.0, json_mode=True)

# Must specified JOSN reply in prompt 
# this works , it NOT , it will fail 
response = llm.complete("Who is Paul Graham? response in json format")
print(response)

# Must specified JOSN reply in prompt 
# this works 
response = llm.complete("**Instruction*** response in json format\n Who is Paul Graham? ")
print(response)

