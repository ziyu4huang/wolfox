# main.nim
{.passL: "libmylib.a".}  # Link against the static library

type
  CallbackType* = proc(value: cint) {.cdecl.} 

proc myCallback(value: cint) {.cdecl.} =
  echo "Callback called with value: ", value

proc call_with_five(callback: CallbackType) {.importc, gcsafe.}

proc main() =
  call_with_five(myCallback)

main()
