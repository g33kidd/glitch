# Package
version       = "0.1.0"
author        = "Josh 💙"
description   = "Cyber/retro/vaporwave glitch image editor."
license       = "MIT"
srcDir        = "src"
bin           = @["glitch"]

# Dependencies
requires "nim >= 1.4.2"
requires "nimgl >= 1.0.0"

# Tasks
task gdev, "Run glitch in development mode":
    exec "nimble run --outdir:'build' --verbosity:3"