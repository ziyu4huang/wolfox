# This is just an example to get you started. A typical binary package
# uses this file as the main entry point of the application.
#


import std/[asyncdispatch, httpclient]

proc asyncProc(): Future[string] {.async.} =
  var client = newAsyncHttpClient()
  return await client.getContent("https://google.com")


when isMainModule:
  echo waitFor asyncProc()
