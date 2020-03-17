local composer = require( "composer" )
local options = {
  effect = "fade",
  time = 800,
}
--loads the title scene
composer.gotoScene( "title", options )
