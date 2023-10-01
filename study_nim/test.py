# test.py
import os


import mymodule
"""
  what?
"""
assert mymodule.greet("world") == "Hello, world!"
assert mymodule.greet(name="world") == "Hello, world!"
print("xyz")

os.getcwd()
print(os.path.realpath("test.py"))


