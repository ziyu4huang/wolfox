from macros import error
from strutils import `%`, endsWith, strip, replace
from sequtils import filterIt, concat

const
  nimVersion = (major: NimMajor, minor: NimMinor, patch: NimPatch)

#switch("backend", "cpp")
switch("app", "console")
switch("outdir", "bin")
