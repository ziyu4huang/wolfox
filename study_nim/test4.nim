# Compile with C++ backend
{.compile: "cpp".}

# Include C++ <algorithm> and <vector> headers
{.header: "<algorithm>".}
{.header: "<vector>".}

# Define C++ vector type
type
  CppVector {.importcpp: "std::vector<int>", header: "<vector>".} = object

# Import std::sort function from C++ STL
proc cppSort {.importcpp: "std::sort(@.begin(), @.end())", header: "<algorithm>".} (x: ptr CppVector)

# Import push_back function to add elements to std::vector
proc push_back {.importcpp: "@.push_back(#)".} (x: ptr CppVector, y: cint)

# Nim main procedure
proc main() =
  var x: CppVector
  # Populate the vector 'x'
  push_back(addr x, 5)
  push_back(addr x, 1)
  push_back(addr x, 9)
  push_back(addr x, 3)
  push_back(addr x, 7)

  echo "Before sorting: ", x

  # Sort the vector using std::sort
  cppSort(addr x)

  echo "After sorting: ", x

# Run the main procedure
main()

