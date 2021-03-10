import streams

proc loadShaderFromFileStream(fs: ptr FileStream) : string =
  doAssert fs != nil
  var line = ""
  var file_stream = cast[FileStream](fs)

  # Cannot eval at compile time.
  # !
  # !
  # Looking at https://forum.nim-lang.org/t/1005
  # and this https://nim-lang.org/docs/streams.html
  when readLine(file_stream, line):
    result.add(line)
    echo line
  echo result
