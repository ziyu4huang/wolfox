import dynlib
#{.compile: "c".}

# Define the initialization function
proc Tcl_MyExtension_Init(interp: pointer): cint {.exportc,dynlib.} =
  echo "Initializing My Tcl Extension"
  return 0  # TCL_OK

# Define the unload function
proc Tcl_MyExtension_Unload(interp: pointer, flags: cint): cint {.exportc,dynlib.} =
  echo "Unloading My Tcl Extension"
  return 0  # TCL_OK

# Export the initialization and unload functions
export Tcl_MyExtension_Init, Tcl_MyExtension_Unload

