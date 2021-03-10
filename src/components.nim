import nimgl/[glfw, imgui]

proc renderExampleComponent(display: ptr bool) {.cdecl.} =

  var 
    counter: uint32 = 0
    somefloat: float32 = 0.0f
    windowFlags = (
      ImGuiWindowFlags.NoTitleBar.int32 or
      ImGuiWindowFlags.NoMove.int32 or
      ImGuiWindowFlags.NoResize.int32
    ).ImGuiWindowFlags

  var time: float64 = glfwGetTime()

  igBegin("Hello, world!", display, windowFlags)

  igText("This is some useful text.")
  igSliderFloat("float", somefloat.addr, 0.0f, 1.0f)

  if igButton("Button", ImVec2(x: 0, y: 0)):
    inc counter
    
  igSameLine()
  igText("counter = %d", addr time)

  igText("Application average %.3f ms/frame (%.1f FPS)", 1000.0f / igGetIO().framerate, igGetIO().framerate)
  igEnd()

export renderExampleComponent