
#Calling Python From Nim

import os
import nimpy
let pyos = pyImport("os")
echo "Current dir is: ", pyos.getcwd().to(string)

# sum(range(1, 5))
let py = pyBuiltinsModule()
let s = py.sum(py.range(0, 5)).to(int)
assert s == 10

discard pyImport("sys").path.append(os.getCurrentDir())

let mymodule = pyImport("mymodule")
discard mymodule.greet("hehe")

let np = pyImport("numpy")

let my = pyImport("mypymodule")
discard my.testfn()

