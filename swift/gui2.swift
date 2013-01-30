import Cocoa

NSApplication.sharedApplication()

let window = NSWindow(contentRect: NSMakeRect(0, 0, 320, 200),
        styleMask: NSTitledWindowMask,
        backing: .Buffered,
        `defer`: true)
window.orderFrontRegardless()

NSApp.run()
