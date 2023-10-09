from sys.intrinsics import external_call

# https://man7.org/linux/man-pages/man3/dlopen.3.html
# void *dlopen(const char *filename, int flags);
# void *dlsym(void *handle, const char *symbol);

# Types aliases
#alias c_void = UInt8
alias c_void = UInt64
alias c_char = UInt8
alias c_int = Int32
alias c_size_t = Int

fn to_char_ptr(s: String) -> Pointer[c_char]:
    """Only ASCII-based strings."""
    let ptr = Pointer[c_char]().alloc(len(s))
    for i in range(len(s)):
        ptr.store(i, ord(s[i]))
    return ptr

let RTLD_LAZY = 0x00001
let RTLD_NOW = 0x00002

fn main():
    let data = "./libexample.so"
    #let data = "/home/ziyu4huang/proj/wolfox/study_mojo/sharelib/libexample.so"
    let data_ptr = to_char_ptr(data)
    #let flag: c_int = RTLD_NOW
    let flag: c_int = RTLD_LAZY
    #let flag: c_int = 0

    let hdl = external_call["dlopen", c_void, Pointer[c_char], c_int](data_ptr, flag)
    print("hdl ", hdl)

    if hdl == 0:
        let error_msg_cstr = external_call["dlerror", Pointer[c_char]]()
        let msg = StringRef(error_msg_cstr.bitcast[Int8]())
        print("lib_handler error ", msg)
    else:
        let error_msg_cstr = external_call["dlerror", Pointer[c_char]]()
        print("lib_handler ", hdl)
        let sym_name = to_char_ptr("hello_world")
        let fun_sym = external_call["dlsym", c_void, c_void, Pointer[c_char]](hdl, sym_name)
        print("fun_sym", fun_sym)

    print("end of main()")
