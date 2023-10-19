
import yaml, streams
type Person = object
  name : string
  age  : int32

var personList: seq[Person]
var s = newFileStream("in1.yaml")
load(s, personList)
s.close()
echo personList[0]
echo personList[1]
echo personList[2]
echo personList


