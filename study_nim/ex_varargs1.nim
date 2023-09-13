proc printf(formatstr: cstring) {.nodecl, importc, varargs.}

printf("hallo %s\n", "world") # "world" will be passed as C string
