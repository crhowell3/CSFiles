local composer = require( "composer" )
local options = {
  effect = "fade",
  time = 800,
}
display.setStatusBar(display.HiddenStatusBar)
print(display.contentWidth / 2, display.contentHeight / 2)
--loads the title scene
composer.gotoScene( "title", options )
