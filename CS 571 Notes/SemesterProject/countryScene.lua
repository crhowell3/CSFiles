--[[
This is the opening scene that shows the country overlay. Contains all 50 states represented as tappable squares.
NOTE: I cannot show the recoveries, as that data was not given in daily increments. I could show an overview of the recoveries in terms of the
entire country, but that would not fit with the time scale.
]]
local composer = require( "composer" )
local scene = composer.newScene()

local stateObjTable

function scene:create(event)
  local sceneGroup = self.view
  local params = event.params
  stateObjTable = params.sot
  display.setDefault("background", 208/255, 200/255, 189/255)
  local title = display.newText(
    {
      text = "Test",
      fontSize = 50,
      x = display.contentCenterX,
      y = display.contentCenterY,
    }
  )
end

function scene:show(event)
  composer.removeScene("stateScene")
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
