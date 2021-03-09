import nimgl/imgui, nimgl/imgui/[impl_opengl, impl_glfw]
import nimgl/[opengl, glfw]

proc keyCallback(window: GLFWWindow, key: int32, scancode: int32, action: int32, mods: int32) {.cdecl.} =
  if action == GLFW_PRESS and key == GLFWKey.Escape:
    window.setWindowShouldClose(true)

# Creates the default igFrame
proc createDefaultFrame() {.cdecl.} =
  igOpenGL3NewFrame()
  igGlfwNewFrame()
  igNewFrame()

# Handles shutting everything down, or at least things we need to shut down at the end.
proc shutdown(window: GLFWWindow, ctx: ptr ImGuiContext) : void =
  assert window != nil
  assert ctx != nil

  # End it all!
  igOpenGL3Shutdown()
  igGlfwShutdown()
  ctx.igDestroyContext()
  window.destroyWindow()
  glfwTerminate()


# Application Start
if isMainModule:

  # Setup the GLFW Window
  doAssert glfwInit()

  # window hints
  glfwWindowHint(GLFWContextVersionMajor, 3)
  glfwWindowHint(GLFWContextVersionMinor, 3)
  glfwWindowHint(GLFWOpenglForwardCompat, GLFW_TRUE)
  glfwWindowHint(GLFWOpenglProfile, GLFW_OPENGL_CORE_PROFILE)
  glfwWindowHint(GLFWResizable, GLFW_FALSE)

  # Create the window and make sure it exists 
  var window: GLFWWindow = glfwCreateWindow(1280, 720, "GLエTCH", nil, nil)
  doAssert window != nil

  discard window.setKeyCallback(keyCallback)
  window.makeContextCurrent()

  doAssert glInit()

  # Setting up the imgui context
  let context = igCreateContext()
  assert context != nil

  doAssert igGlfwInitForOpenGL(window, true)
  doAssert igOpenGL3Init()
  igStyleColorsDark()

  # The running loop I guess.
  while not window.windowShouldClose:
    glfwPollEvents()
    createDefaultFrame()

    # ===
    # Application code should go here, well as far as rendering a basic window.
    # At the moment I'm not sure if you need to call igRender() after each igEnd() or not.
    # ===

    igRender()

    glClearColor(0.45f, 0.55f, 0.60f, 1.00f)
    glClear(GL_COLOR_BUFFER_BIT)

    igOpenGL3RenderDrawData(igGetDrawData())

    window.swapBuffers()

  # When the application closes.
  shutdown(window, context)