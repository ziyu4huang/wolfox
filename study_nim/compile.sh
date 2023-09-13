
nim c --app:lib --out:mymodule.so --threads:on mymodule
nim c nimpy_integ.nim 

nim c --app:lib -d:release tcluuid.nim
