import json

# First we'll define our types
type
  Element = object
    name: string
    atomicNumber: int
    nodefine: float


# Let's say this is the JSON we want to convert
let jsonObject = parseJson("""{"name": "Carbon", "atomicNumber": 6, "nodefine": 1.2}""")

let element = to(jsonObject, Element)
# This will print Carbon
echo element.name
# This will print 6
echo element.atomicNumber

echo element
