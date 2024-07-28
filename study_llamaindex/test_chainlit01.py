import chainlit as cl

from os import environ

environ["GRPC_DNS_RESOLVER"] = "native"
environ["GRPC_TRACE"] = "api,client_channel_routing,cares_resolver" 
environ["GRPC_VERBOSITY"] = "debug"

@cl.on_message
async def main(message: cl.Message):
    # Your custom logic goes here...

    # Send a response back to the user
    await cl.Message(
        content=f"Received: {message.content}",
    ).send()

