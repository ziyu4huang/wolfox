# mymodule.nim - file name should match the module name you're going to import from python
import nimpy

proc greet(name: string): string {.exportpy.} =
  return "Hello, " & name & "!"


# Compile on Windows:
#nim c --app:lib --out:mymodule.pyd --threads:on --tlsEmulation:off --passL:-static mymodule
# Compile on everything else:
#nim c --app:lib --out:mymodule.so --threads:on mymodule
