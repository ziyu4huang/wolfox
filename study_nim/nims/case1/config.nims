#!/usr/bin/env -S nim -e --hints:off
# ref to  /home/ziyu4huang/.choosenim/toolchains/nim-2.0.0/config/config.nims
#
switch("hints", "off")
switch("define", "ssl")
# also  https://nim-lang.org/docs/nims.html
# NimScript as a configuration file
#

#https://github.com/kaushalmodi/nim_config#list-available-tasks
import std/distros

# Architectures.
if defined(amd64):
  echo "Architecture is x86 64Bits"
elif defined(i386):
  echo "Architecture is x86 32Bits"
elif defined(arm):
  echo "Architecture is ARM"

# Operating Systems.
if defined(linux):
  echo "Operating System is GNU Linux"
elif defined(windows):
  echo "Operating System is Microsoft Windows"
elif defined(macosx):
  echo "Operating System is Apple OS X"

# Distros.
if detectOs(Ubuntu):
  echo "Distro is Ubuntu"
elif detectOs(ArchLinux):
  echo "Distro is ArchLinux"
elif detectOs(Debian):
  echo "Distro is Debian"
##################################

task my, "builds an example":
  setCommand "c"
# also https://github.com/kaushalmodi/nim_config#list-available-tasks

task my_bad, "a task":
  echo("hello")
