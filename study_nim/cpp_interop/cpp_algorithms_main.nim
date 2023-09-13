
{.compile: "cpp_algorithms.cpp".}

type
  csize_t {.importc: "size_t", header: "<stddef.h>".} = int

proc sortArray(arr: ptr cint, size: csize_t) {.importcpp: "sortArray(@, @)", header: "cpp_algorithms.h".}

# Usage
var myArray = [4, 2, 3, 1]
var myArrayPtr = myArray[0].addr

sortArray(cast[ptr cint](myArrayPtr), (myArray.len.csize_t))

echo myArray  # Output should be [1, 2, 3, 4]



