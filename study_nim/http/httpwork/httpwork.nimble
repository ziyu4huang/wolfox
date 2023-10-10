# Package

version       = "0.1.0"
author        = "ziyu4huang"
description   = "0.1.0"
license       = "MIT"
srcDir        = "src"
bin           = @["httpwork"]


# Dependencies

requires "nim >= 2.0.0"

switch("d", "ssl")

