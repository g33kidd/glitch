const EXAMPLE_VERTEX_SHADER: string = 
  """
#version 110
uniform mat4 MVP;
attribute vec3 vCol;
attribute vec2 vPos;
varying vec3 color;
void main()
{
    gl_Position = MVP * vec4(vPos, 0.0, 1.0);
    color = vCol;
}
  """

const EXAMPLE_FRAGMENT_SHADER: string = 
  """
#version 110
varying vec3 color;
void main()
{
    gl_FragColor = vec4(color, 1.0);
}
  """


export EXAMPLE_VERTEX_SHADER
export EXAMPLE_FRAGMENT_SHADER