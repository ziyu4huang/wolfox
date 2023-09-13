import tcl

proc Square_Cmd(clientData: ClientData, interp: Tcl_Interp, argc: cint, argv: cstring): cint {.cdecl.} =
  if argc != 2:
    Tcl_SetResult(interp, "Wrong number of arguments", TCL_STATIC)
    return TCL_ERROR

  let num = parseInt($argv[1])
  let square = num * num
  Tcl_SetObjResult(interp, Tcl_NewIntObj(square))
  return TCL_OK

proc Nim_Tcl_Init(interp: Tcl_Interp): cint {.cdecl, exportc.} =
  if Tcl_InitStubs(interp, "8.5", 0) == nil:
    return TCL_ERROR

  Tcl_CreateCommand(interp, "square", Square_Cmd, nil, nil)
  return TCL_OK



