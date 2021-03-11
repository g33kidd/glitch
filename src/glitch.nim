import nimgl/imgui, nimgl/imgui/[impl_opengl, impl_glfw]
import nimgl/[opengl, glfw]

# import ./files

import ./shapes
import ./components
import ./text
import ./handlers
import ./shaders

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

# var line: string = ""
# var result: string = ""

# if not isNil(fs):
#   when readLine(fs, line):
#     result.add(line)
#     echo line


if isMainModule:
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
    vbo: GLuint = GLuint(0) # Vertex Buffer Object
    vao: GLuint = GLuint(0)# Vertex Array Object
    w: GLint = GLint(defaultW)
    h: GLint = GLint(defaultH)
    tri_vertex_array: seq[float32] =
      @[
        0.5'f32, -0.5'f32, 0.0'f32,  1.0'f32, 0.0'f32, 0.0'f32,  # bottom right
        -0.5'f32, -0.5'f32, 0.0'f32,  0.0'f32, 1.0'f32, 0.0'f32,  # bottom left
        0.0'f32,  0.5'f32, 0.0'f32,  0.0'f32, 0.0'f32, 1.0'f32 ]

  var tri_vertex_array_isize = GLsizeiptr sizeof(triangle_vertex_array)
  # Setting up the vertex buffer object
  glGenBuffers 1, addr(vbo)
  glBindBuffer GL_ARRAY_BUFFER, vbo
  glBufferData GL_ARRAY_BUFFER, tri_vertex_array_isize, addr tri_vertex_array, GL_STATIC_DRAW

  # Setting up the vertex array object, which keeps track of buffers that you want to use.
  # It also stores the memory address of each one you want to use in memory.
  glGenVertexArrays 1, addr(vao)
  glBindVertexArray vao
  glEnableVertexAttribArray 0
  glBindBuffer GL_ARRAY_BUFFER, vbo
  glVertexAttribPointer(
    0.GLuint, 
    3.GLint, 
    GLenum(0), # ! GL_FLOAT.GLenum is supposed to work???
    GL_FALSE.GLboolean, 
    GLsizei(0), cast[ptr GLvoid](0))
  # glVertexAttribPointer GLuint(0), GLint(3), GL_FLOAT, GL_FALSE, GLsizei(0), pointer(nil)

  let context = igCreateContext()
  assert context != nil

  doAssert igGlfwInitForOpenGL(window, true)
  doAssert igOpenGL3Init()
  igStyleColorsDark()

  var display_example_component: ptr bool
  var swapint: int32 = 1

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

    getFramebufferSize window, addr w, addr h
    glViewport 0, 0, w, h

    glfwSwapInterval swapint # not sure if this needs to be moved elsewhere..
    swapBuffers window

  shutdown(window, context)