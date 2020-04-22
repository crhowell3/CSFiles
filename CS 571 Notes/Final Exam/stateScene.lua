local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")
local State = require ("state");

local stateSquare = State:new({});

function onClick(event)
  local options = {
    effect = "fade",
    time = 800
  }
  composer.gotoScene("countyScene", options)
end

function stateSquare:spawn()

end

function stateSquare:touch()

end

function stateSquare:display()

end

function scene:create(event)
  local sceneGroup = self.view
  local params = event.params
  stateList = params.st
  local options = {
    x = display.contentWidth - 150,
    y = 100,
    width = 100,
    height = 50
  }
  local countyButton = widget.newButton( options )
  countyButton.anchorX = 0.5
  countyButton.anchorY = 0.5
  local text = display.newText(
    {
      text = "County >",
      fontSize = 50
    }
  )
  text.x = countyButton.x
  text.y = countyButton.y
  countyButton.text = text
  countyButton:addEventListener("tap", onClick)
  countyButton.isVisible = true
  sceneGroup:insert(countyButton)
  sceneGroup:insert(text)
end

function scene:show(event)
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
