--[[
This is the scene that shows whenever a state is tapped into, and it shows county-level details about the state, as well as total numbers.
NOTE: I cannot show recoveries for either the states or the counties because that data was not made avaibable in daily increments.
]]
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create(event)
  local sceneGroup = self.view
end

function scene:show(event)
  composer.removeScene("countryScene")
  local sceneGroup = self.view
end

function scene:hide(event)
  local sceneGroup = self.view
  local phase = event.phase
  if ( phase == "will" ) then
  elseif ( phase == "did" ) then
  end
end

function scene:destroy(event)
  local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
