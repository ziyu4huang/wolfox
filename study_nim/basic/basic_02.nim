
from std/strutils import join
from std/sequtils import mapIt
from std/strformat import fmt

proc style1() =
  const DefaultWorldRange = [0.0, 0, 800, 600]
  let str = DefaultWorldRange.mapIt(fmt("{it:g}")).join(", ")
  echo str # "0, 0, 800, 600"


proc style2() =
  const DefaultWorldRange = [0.0, 0, 800, 600]
  var str: string
  for i, x in pairs(DefaultWorldRange):
    str.add(fmt("{x:g}"))
    if i < DefaultWorldRange.high:
      str.add(", ")
  echo str # "0, 0, 800, 600"

style1()
echo "xxxxxxxxxxxxxxxx"
style2()



