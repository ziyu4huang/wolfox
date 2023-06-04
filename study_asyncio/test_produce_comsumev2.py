import asyncio
import subprocess
import time

def run_shell_command(cmd) -> str:
    print(f"run_shell_command: {cmd}")
    # time.sleep(10)
    proc = subprocess.run(cmd, capture_output=True, check=True)
    return proc.stdout.decode()

async def run_subprocess_in_thread_pool(cmd):
    loop = asyncio.get_event_loop()
    # run the subprocess in a thread pool
    # this not working
    #proc = await loop.run_in_executor(None, subprocess.run, cmd, capture_output=True)
    #return proc.stdout.decode()
    result = await loop.run_in_executor(None, run_shell_command, cmd)
    return result

async def producer(queue, commands):
    for cmd in commands:
        await queue.put(cmd)
    await queue.put(None)

async def consumer(queue):
    while True:
        cmd = await queue.get()
        if cmd is None:
            break
        output = await run_subprocess_in_thread_pool(cmd)
        print(output)

async def main():
    commands = [["ls", "-l"], ["echo", "hello world"], ["whoami"]]
    buffer_size = 5

    queue = asyncio.Queue(maxsize=buffer_size)
    producer_task = asyncio.create_task(producer(queue, commands))
    consumer_task = asyncio.create_task(consumer(queue))

    await asyncio.gather(producer_task, consumer_task)

if __name__ == "__main__":
    asyncio.run(main())
