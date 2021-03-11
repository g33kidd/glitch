# Imported font files
import nimgl/imgui
import ../assets/fonts/roboto_regular

  
  # Ensure our font(s) are loaded
  # let io: ptr ImGuiIO = igGetIO()  
  # setupFonts(io.fonts)

proc setupFonts(font_atlas: ptr ImFontAtlas) {.cdecl.} =
  assert font_atlas != nil

  # Sets the default font for the application, in-case we can't find the others or something goes wrong
  addFontDefault(font_atlas)

  var font_data: pointer = addr s_robotoRegularTtf

  igImFontAtlasBuildInit(font_atlas)

  var roboto_font: ptr ImFont = addFontFromMemoryCompressedTTF(
    font_atlas, 
    font_data, 
    int32 sizeof(s_robotoRegularTtf), 
    18.0f, 
    nil,
    getGlyphRangesDefault(font_atlas)
  )

  # igImFontAtlasBuildSetupFont(font_atlas, roboto_font, font_config, 0.0f, 0.0f)
  igImFontAtlasBuildFinish(font_atlas)
  igSetCurrentFont(roboto_font)