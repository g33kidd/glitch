import nimgl/glfw

# TODO finish implementing a proper error handler for GLFW
# proc errorCallback(error_code: int, description: string) {.cdecl.} =
#   echo "there has been an error", description

# Handles the keyCallback from GLFW.
# 
# The window should most definitely be closed if the ESC key is pressed.
# 
proc keyCallback(window: GLFWWindow, key: int32, scancode: int32, action: int32, mods: int32) {.cdecl.} =
  if action == GLFW_PRESS and key == GLFWKey.Escape:
    window.setWindowShouldClose(true)

export keyCallback