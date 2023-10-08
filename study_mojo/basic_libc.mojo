from sys.intrinsics import external_call

fn main():
    let r = external_call["getpagesize", Int32]()
    print("Page size is ", r)
    print("end of main()")