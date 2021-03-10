import nimgl/imgui, nimgl/imgui/[impl_opengl, impl_glfw]
import nimgl/[opengl, glfw]

# import ./files

import ./components
import ./text
import ./handlers

var
  defaultW: int32 = 1280
  defaultH: int32 = 720


# Creates the default igFrame
proc initFrame() {.cdecl.} =
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

proc main() =
  # Setup the GLFW Window
  doAssert glfwInit()

  # TODO handlers.nim
  # glfwSetErrorCallback(errorCallback)

  # window hints
  glfwWindowHint(GLFWSamples, 4)
  glfwWindowHint(GLFWContextVersionMajor, 3)
  glfwWindowHint(GLFWContextVersionMinor, 3)
  glfwWindowHint(GLFWOpenglForwardCompat, GLFW_TRUE)
  glfwWindowHint(GLFWOpenglProfile, GLFW_OPENGL_CORE_PROFILE)
  glfwWindowHint(GLFWResizable, GLFW_FALSE)

  # Create the window and make sure it exists 
  var window: GLFWWindow = glfwCreateWindow(defaultW, defaultH, "GLエTCH", nil, nil)
  doAssert window != nil

  discard window.setKeyCallback(keyCallback)
  window.makeContextCurrent()

  doAssert glInit()
  
  var 
    w: GLint = cast[GLint](defaultW)
    h: GLint = cast[GLint](defaultH)

  # Honestly I'm not sure what to do with that at the moment.
  getFramebufferSize(window, addr w, addr h)
  glViewport(0, 0, w, h)


  # Setting up the imgui context
  let context = igCreateContext()
  assert context != nil

  doAssert igGlfwInitForOpenGL(window, true)
  doAssert igOpenGL3Init()
  igStyleColorsDark()

  var display_example_component: ptr bool
  var swapint: int32 = 1

  # var imageBuffer: array[int32, byte] = array[4, byte]
  # let testFile: File = open("../assets/image.png")
  # readBuffer(testFile, imageBuffer, 0)
  # defer: testFile.close()

  
  # Ensure our font(s) are loaded
  # let io: ptr ImGuiIO = igGetIO()  
  # setupFonts(io.fonts)

  # The running loop I guess.
  while not window.windowShouldClose:
    glfwPollEvents()
    initFrame()

    # Simple window
    renderExampleComponent(display_example_component)
    # End simple window

    igRender()

    # glClearColor(0.45f, 0.55f, 0.60f, 1.00f)
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT)

    igOpenGL3RenderDrawData igGetDrawData()

    glfwSwapInterval swapint # not sure if this needs to be moved elsewhere..
    swapBuffers window

  # When the application closes.
  main()
  shutdown(window, context)