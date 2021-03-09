# Package

version       = "0.1.0"
author        = "Josh 💙"
description   = "Cyber/retro/vaporwave glitch image editor."
license       = "MIT"
srcDir        = "src"
bin           = @["glitch"]

# Dependencies
# TODO move deps away from vendor folder at some point.
# The SSL/CA Certificate stuff doesn't really work right now :|
requires "nim >= 1.4.2"
requires "nimgl >= 1.0.0"

task gdev, "Run glitch in development mode":
    exec "nimble run --outdir:build --verbosity:3"
# # Nimble Tasks
# # TODO I don't know how this works, but I assume this is somewhat correct.
# task glitchDev, "Run application in development":
#     exec """nim c --cincludes:"private/cimgui/cimgui.h" --outdir:build --verbosity:3 -r ./src/glitch.nim --passL:'-static -lglfw3 -lmingw32 -mwindows -Wl,--no-undefined -Wl,--dynamicbase -Wl,--nxcompat -Wl,--high-entropy-va -lm -ldinput8 -lcimgui -ldxguid -ldxerr8 -luser32 -lgdi32 -lwinmm -limm32 -lole32 -loleaut32 -lshell32 -lsetupapi -lversion -luuid'"""