import std/macros

macro myAssert(arg: untyped): untyped =
  # all node kind identifiers are prefixed with "nnk"
  arg.expectKind nnkInfix
  arg.expectLen 3
  # operator as string literal
  let op  = newLit(" " & arg[0].repr & " ")
  let lhs = arg[1]
  let rhs = arg[2]
  
  result = quote do:
    if not `arg`:
      raise newException(AssertionDefect,$`lhs` & `op` & $`rhs`)

let a = 1
let b = 2

myAssert(a != b)
myAssert(a == b)
