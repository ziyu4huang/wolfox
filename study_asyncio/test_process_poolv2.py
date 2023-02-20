"""
module doc string
"""
from concurrent.futures import Future
from concurrent.futures import ProcessPoolExecutor as Pool

class FortranRunner():
    """
    the
    """
    def __init__(self, name: str) -> None:
        self.name = name

    def fortran_callback(self, future: Future):
        """
        the
        """
        print("callback executor name: " + self.name)
        print(" annd", future.run_type, future.jid)
        return "Fortran finished executing"

def fortran_execute():
    """
    the
    """

    ftr1 = FortranRunner(name="run1")
    ftr2 = FortranRunner(name="run2")
    ftr3 = FortranRunner(name="run3")

    args1 = "sleep 1; echo 'still running (1)'; sleep 2; echo complete"
    args2 = "sleep 1; echo 'still running (2)'; sleep 2; echo complete"
    args3 = "sleep 1; echo 'still running (3)'; sleep 2; echo complete"

    pool = Pool(max_workers=2)
    future1 = pool.submit(subprocess.call, args1, shell=1)
    future1.run_type = "run_type"
    future1.jid = "jid 1"
    future1.add_done_callback(ftr1.fortran_callback)

    future2 = pool.submit(subprocess.call, args2, shell=1)
    future2.run_type = "run_type"
    future2.jid = "jid 2"
    future2.add_done_callback(ftr2.fortran_callback)

    future3 = pool.submit(subprocess.call, args3, shell=1)
    future3.run_type = "run_type"
    future3.jid = "jid 3"
    future3.add_done_callback(ftr3.fortran_callback)

    print("Fortran executed")
    pool.shutdown(wait=True)

    print("Executor finish")


if __name__ == '__main__':
    import subprocess
    fortran_execute()
