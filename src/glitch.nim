# Copyright 2018, NimGL contributors.

import nimgl/imgui, nimgl/imgui/[impl_opengl, impl_glfw]
import nimgl/[opengl, glfw]

proc keyCallback(window: GLFWWindow, key: int32, scancode: int32, action: int32, mods: int32) {.cdecl.} =
  if action == GLFW_PRESS and key == GLFWKey.Escape:
    window.setWindowShouldClose(true)

# Creates the default igFrame
proc createDefaultFrame() : void =
  igOpenGL3NewFrame()
  igGlfwNewFrame()
  igNewFrame()

# Handles shutting everything down, or at least things we need to shut down at the end.
proc shutdown(window: GLFWWindow, ctx: ptr ImGuiContext = nil) : void =
  igOpenGL3Shutdown()
  igGlfwShutdown()
  ctx.igDestroyContext()
  glfwTerminate()

var counter: int32 = 0

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

  # Setting up the imgui context
  let context = igCreateContext()
  assert context != nil

  doAssert igGlfwInitForOpenGL(window, true)
  doAssert igOpenGL3Init()

  # The running loop I guess.
  while not window.windowShouldClose:
    glfwPollEvents()
    createDefaultFrame()
    igRender()

  # When the application closes.
  shutdown(window, context)