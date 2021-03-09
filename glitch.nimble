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
requires "nim >= 1.4.4"

# Nimble Tasks
task glitch, "Run application in development":