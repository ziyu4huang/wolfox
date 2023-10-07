import nodesnim

Window("Hello, world!")


build:
  - Scene scene:
    - Label hello:
      call:
        setSizeAnchor(1, 1)
        setTextAlign(0.5, 0.5, 0.5, 0.5)
        setText("Hello, world!")
        setBackgroundColor(Color(31, 45, 62))

addMainScene(scene)
windowLaunch()
1
