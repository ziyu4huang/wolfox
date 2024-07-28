
from llama_index.llms.ollama import Ollama
from llama_index.core.llms import ChatMessage

llm = Ollama(model="llama3", request_timeout=120.0)


messages = [
    ChatMessage(
        role="system", content="You are a pirate with a colorful personality"
    ),
    ChatMessage(role="user", content="What is your name"),
]
resp = llm.chat(messages)

print("response")
print(resp)

llm = Ollama(model="llama3", request_timeout=120.0, json_mode=True)

messages = [
    ChatMessage(
        role="system", content="Reply message using json format"
    ),
    ChatMessage(role="user", content="Where is Taipei? and it's description"),
]
resp = llm.chat(messages)

print("response")
print(resp)

