# this is not working
import std/times

type A = object
  str: string
  num: int
  floatNum: float
  dateTime: DateTime
  boolean: bool

type B = object
  str: string
  num: int
  floatNum: float
  dateTime: DateTime
  boolean: bool

let a = A(
  str: "str",
  num: 5,
  floatNum: 2.5,
  dateTime: now(),
  boolean: true
)

proc myMapProc(x: A): B {.map.} = discard # Will transfer all fields of A to B

let myB: B = myMapProc(a)


proc myMapProcTripleNum(x: A): B {.map.} =
  # Perfectly valid, it's just a proc with extra stuff added before the proc-body!
  result.num = x.num * 3
  echo "Assigned triple num!"

let myB2: B = myMapProcTripleNum(a)
