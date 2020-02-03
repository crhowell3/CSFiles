local widget = require("widget")

local progressView = widget.newProgressView(
  {
    left = 50,
    top = 200,
    width = 220,
    isAnimated = true
  }
)

progressView:setProgress( 0.5 )
