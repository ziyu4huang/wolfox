#import os, strutils


task gen, "genreate NIM code":
  echo "call gen"
# Run pkg-config to get the header path
  #let headerPath = execShellCmd("pkg-config --cflags-only-I geos_c")
  #let cleanedPath = headerPath.replace("-I", "").strip()

# Generate Nim code for the pragma
  #let nimCode = """{.pragma: impgeos_cHdr, header: r\""" & cleanedPath & "/geos_c.h\"\"\".}"""

# Write the pragma to a Nim file
  let nimCode = ""
  writeFile("generated_header.nim", nimCode)

