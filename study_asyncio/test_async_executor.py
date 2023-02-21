"""
Doc
"""
import asyncio
from asyncio.base_events import BaseEventLoop as EventLoop
from time import sleep


def fetch(url):
    """
    fetch here
    """
    print(f"start fetch {url}")
    sleep(3)
    print(f"end fetch {url}")

async def main():
    """
    run fetch multiple in same time
    """
    #https://docs.python.org/3/library/asyncio-eventloop.html#asyncio.loop.run_in_executor
    futures = [loop.run_in_executor(None, fetch, url) for url in range(50)]
    while futures:
        #https://docs.python.org/3/library/asyncio-task.html#asyncio.wait
        done, futures = await asyncio.wait(futures, return_when=asyncio.FIRST_COMPLETED)
        for f_job in done:
            await f_job

#https://docs.python.org/3/library/asyncio-eventloop.html#asyncio.get_event_loop
loop: EventLoop = asyncio.get_event_loop()
loop.run_until_complete(main())
