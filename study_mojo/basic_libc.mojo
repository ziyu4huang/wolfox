from sys.intrinsics import external_call

@value
@register_passable("trivial")
struct DIR:
    pass


@value
@register_passable("trivial")
struct dirent:
    var d_ino: UInt64
    var d_off: UInt64
    var d_reclen: UInt16
    var d_type: UInt8
    var d_name: Pointer[UInt8]


fn main():
    let r = external_call["getpagesize", Int32]()
    print("Page size is ", r)

    let r2 = __mlir_op.`pop.external_call`[func="getpagesize".value, _type=Int32]()
    print("Page size is ", r2)


    let r3 = __mlir_op.`pop.external_call`[func="opendir".value, _type=Pointer[Int8]](".".value)
    #print("Page size is ", r3)

    let dirent1 = __mlir_op.`pop.external_call`[func="readdir".value, _type=Pointer[dirent]](r3)
    #print("d_ino: ", dirent1)

    let r4 = __mlir_op.`pop.external_call`[func="closedir".value, _type=Int32](r3)
    # 0 is success
    print("closedir result: ", r4)
    # let r5 = __mlir_op.`pop.external_call`[func="closedir".value, _type=Int32](r3)
    # print("closedir result: ", r5)


    print("end of main()")