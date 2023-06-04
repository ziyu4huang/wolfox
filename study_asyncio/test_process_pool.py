"""
module doc string
"""
from concurrent.futures import Future
from concurrent.futures import ProcessPoolExecutor as Pool


def fortran_callback(future: Future):
    """
    the
    """
    print(future.run_type, future.jid)
    return "Fortran finished executing"

def fortran_execute():
    """
    the
    """


    args1 = "sleep 1; echo 'still running (1)'; sleep 2; echo complete"
    args2 = "sleep 1; echo 'still running (2)'; sleep 2; echo complete"
    args3 = "sleep 1; echo 'still running (3)'; sleep 2; echo complete"

    pool = Pool(max_workers=2)
    future = pool.submit(subprocess.call, args1, shell=1)
    future = pool.submit(subprocess.call, args2, shell=1)
    future = pool.submit(subprocess.call, args3, shell=1)
    future.run_type = "run_type"
    future.jid = "jid"
    future.add_done_callback(fortran_callback)

    print("Fortran executed")

    pool.shutdown(wait=True)

    print("Executor finish")


if __name__ == '__main__':
    import subprocess
    fortran_execute()
