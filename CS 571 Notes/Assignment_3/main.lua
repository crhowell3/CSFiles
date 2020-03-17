local composer = require( "composer" )
local options = {
  effect = "fade",
  time = 800,
}
display.setStatusBar(display.HiddenStatusBar)

--loads the title scene
composer.gotoScene( "title", options )
