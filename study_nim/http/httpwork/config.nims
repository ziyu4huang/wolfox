
# ref to  /home/ziyu4huang/.choosenim/toolchains/nim-2.0.0/config/config.nims
#
switch("define", "ssl")
# also  https://nim-lang.org/docs/nims.html
# NimScript as a configuration file

task my, "builds an example":
  setCommand "c"
# also https://github.com/kaushalmodi/nim_config#list-available-tasks

task my_bad, "a task":
  print("hello")
