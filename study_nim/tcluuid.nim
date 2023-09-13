
import uuids
from tclstubs as Tcl import nil

# nim c --app:lib -d:release tcluuid.nim

proc Tcluuid_Cmd(clientData: Tcl.PClientData, interp: Tcl.PInterp, objc: cint, objv: Tcl.PPObj): cint =
  Tcl.SetObjResult(interp, Tcl.NewStringObj(cstring($genUUID()),-1))
  return Tcl.OK


proc Tcluuid_Init(interp: Tcl.PInterp): cint {.exportc,dynlib.} =
  echo Tcl.InitStubs(interp, "8.6",0)
  echo Tcl.PkgProvideEx(interp, "nuuid","0.1", nil)
  if Tcl.CreateObjCommand(interp, "uuid", Tcluuid_Cmd, nil, nil)!=nil:
    return Tcl.OK
  else:
    return Tcl.ERROR

proc Tcluuid_Unoad(interp: Tcl.PInterp, flags:cint): cint {.exportc,dynlib.} =
  echo "Unloading My Tcl Extension"
  return Tcl.OK  # TCL_OK

