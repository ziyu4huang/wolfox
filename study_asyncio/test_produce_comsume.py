"""
Dummy
"""
import asyncio
import random

async def producer(queue, max_items):
    """
    Dummy
    """
    for i in range(max_items):
        item = random.randint(1, 10)
        print(f"Produced item: {item}")
        await queue.put(item)
    await queue.put(None)

async def consumer(queue, name=""):
    """
    Dummy
    """
    while True:
        item = await queue.get()
        if item is None:
            break
        print(f"[{name}]create shell Consumed item: {item}")
        #await asyncio.sleep(1)
        cmd = f'echo "start consumed {item} in shell";sleep 2; echo "end consumed {item} in shell"'
        process = await asyncio.create_subprocess_shell(cmd)
        await process.wait()
        print(f"[{name}]end create shell Consumed item: {item}")

async def main():
    """
    Dummy
    """
    max_items = 10
    buffer_size = 5

    queue = asyncio.Queue(maxsize=buffer_size)
    producer_task = asyncio.create_task(producer(queue, max_items))
    consumer_task = asyncio.create_task(consumer(queue, 'A'))

    await asyncio.gather(producer_task, consumer_task)
    # below is not work
    #consumer_task2 = asyncio.create_task(consumer(queue, 'B'))
    #await asyncio.gather(producer_task, consumer_task, consumer_task2 )

if __name__ == "__main__":
    asyncio.run(main())
