from sys.intrinsics import external_call

# https://man7.org/linux/man-pages/man3/dlopen.3.html
# void *dlopen(const char *filename, int flags);
# void *dlsym(void *handle, const char *symbol);

# Types aliases
#alias c_void = UInt8
alias c_void = UInt64
alias c_char = UInt8
alias c_schar = Int8
alias c_uchar = UInt8
alias c_short = Int16
alias c_ushort = UInt16
alias c_int = Int32
alias c_uint = UInt32
alias c_long = Int64
alias c_ulong = UInt64
alias c_float = Float32
alias c_double = Float64

# Note: `Int` is known to be machine's width
alias c_size_t = Int
alias c_ssize_t = Int

alias ptrdiff_t = Int64
alias intptr_t = Int64
alias uintptr_t = UInt64


fn to_char_ptr(s: String) -> Pointer[c_char]:
    """Only ASCII-based strings."""
    let ptr = Pointer[c_char]().alloc(len(s))
    for i in range(len(s)):
        ptr.store(i, ord(s[i]))
    return ptr


fn strlen(s: Pointer[c_char]) -> c_size_t:
    """Libc POSIX `strlen` function.

    Reference: https://man7.org/linux/man-pages/man3/strlen.3p.html
    Fn signature: size_t strlen(const char *s)

    Args: s: A pointer to a C string.
    Returns: The length of the string."""
    return external_call["strlen", c_size_t, Pointer[c_char]](s)

fn c_charptr_to_string(s: Pointer[c_char]) -> String:
    #return String(s.bitcast[Int8](), strlen(s))
    return StringRef(s.bitcast[Int8]())

#/* The MODE argument to `dlopen' contains one of the following: */
#define RTLD_LAZY	0x00001	/* Lazy function call binding.  */
#define RTLD_NOW	0x00002	/* Immediate function call binding.  */
#define	RTLD_BINDING_MASK   0x3	/* Mask of binding time value.  */
#define RTLD_NOLOAD	0x00004	/* Do not load the object.  */
#define RTLD_DEEPBIND	0x00008	/* Use deep binding.  */

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
        #print("lib_handler error ", error_msg_cstr)
        print("lib_handler error len ", strlen(error_msg_cstr))
        #let msg = c_charptr_to_string(error_msg_cstr)
        let msg = StringRef(error_msg_cstr.bitcast[Int8]())
        print("lib_handler error ", msg)
    else:
        let error_msg_cstr = external_call["dlerror", Pointer[c_char]]()
        print("lib_handler ", hdl)
        #let x = external_call["hello_world", c_int]()
        let sym_name = to_char_ptr("hello_world")
        let fun_sym = external_call["dlsym", c_void, c_void, Pointer[c_char]](hdl, sym_name)
        print("fun_sym", fun_sym)

    print("end of main()")
