
import Cocoa

NSApplication.sharedApplication()

let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
statusItem.title = "Quit"
statusItem.action = "terminate:"

NSApp.run()
