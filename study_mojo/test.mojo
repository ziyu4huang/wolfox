
from python import Python
from python.object import PythonObject
from sys import argv


struct MyPair:
    var first: Int
    var second: Int

    # We use 'fn' instead of 'def' here - we'll explain that soon
    fn __init__(inout self, first: Int, second: Int):
        self.first = first
        self.second = second

    fn __lt__(self, rhs: MyPair) -> Bool:
        return self.first < rhs.first or
              (self.first == rhs.first and
               self.second < rhs.second)

fn main():
    print("----syz")
    try:
        let argparse =Python.import_module("argparse")
        
        #let p = argparse.ArgumentParser(prog="test app", usage="good", description="OK, it's good")
        let p = argparse.ArgumentParser("test", "usage")
        
        print("begin argparse")
        print(p)
        _ = p.add_argument("--add")

        print("start parse")
        #var pargs = p.parse_args(["--add", "yes"])
        #sys.argv
        #var pargs = p.parse_args(argv())
        var pargs = p.parse_args(PythonObject(argv()))
        print("11111")
        print(pargs.add)
        print(pargs)
        print("xxxxxx")
        let np = Python.import_module("numpy")
        print("yyyy")
        #print(np.has_avx2())
    except e:
        print("error")
        # print(str(e))

    print("test ")
    let v1 = MyPair(10, 11)
    let v2 = MyPair(10, 10)
    if v1 < v2:
        print("v1 < v2 : ")
    else:
        print("no")
    
    #print(v1)


#main()
