import posix

proc execvp(name: cstring, argv: cstringArray): cint {.importc, header: "<unistd.h>".}

proc createCStringArray(strings: seq[string]): cstringArray =
  let n = strings.len
  result = cast[cstringArray](alloc0((n + 1) * sizeof(cstring)))
  for i in 0 ..< n:
    result[i] = cstring(strings[i])
  result[n] = nil  # Null-terminate the array

# Test the function
let cmd = "ls"
let args = @["-l", "-a"]
let cArgs = createCStringArray(args)

# Add the command as the first argument (convention for execvp)
let fullArgs = @[cmd] & args
let cFullArgs = createCStringArray(fullArgs)

# Execute the command
discard execvp(cmd, cFullArgs)

