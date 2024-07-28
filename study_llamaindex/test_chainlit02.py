# REF https://github.com/TanAlex/langchain-ollama-chainlit/blob/main/simple_chatui.py
from langchain_community.llms import Ollama
from langchain.prompts import ChatPromptTemplate
from langchain.schema import StrOutputParser
from langchain.schema.runnable import Runnable
from langchain.schema.runnable.config import RunnableConfig

import chainlit as cl
from os import environ


environ["GRPC_DNS_RESOLVER"] = "native"
environ["GRPC_TRACE"] = "api,client_channel_routing,cares_resolver" 
environ["GRPC_VERBOSITY"] = "debug"



@cl.on_chat_start
async def on_chat_start():
    # model = Ollama(model="mistral")
    model = Ollama(model="llama3.1")
    prompt = ChatPromptTemplate.from_messages(
        [
            (
                "system",
                "be honest helper, try to answer AI related questions",
            ),
            ("human", "{question}"),
        ]
    )
    runnable = prompt | model | StrOutputParser()
    cl.user_session.set("runnable", runnable)


@cl.on_message
async def on_message(message: cl.Message):
    runnable = cl.user_session.get("runnable")  # type: Runnable

    msg = cl.Message(content="")

    async for chunk in runnable.astream(
        {"question": message.content},
        config=RunnableConfig(callbacks=[cl.LangchainCallbackHandler()]),
    ):
        await msg.stream_token(chunk)

    await msg.send()

