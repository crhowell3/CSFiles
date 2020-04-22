local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")

function scene:create(event)
  local sceneGroup = self.view
  local options = {
    x = 150,
    y = 100,
    width = 100,
    height = 50
  }
  local stateButton = widget.newButton( options )
  stateButton.anchorX = 0.5
  stateButton.anchorY = 0.5
  local text = display.newText(
    {
      text = "< State",
      fontSize = 50
    }
  )
  text.x = stateButton.x
  text.y = stateButton.y
  stateButton.text = text
  --stateButton:addEventListener("tap", onClick)
  stateButton.isVisible = true
  sceneGroup:insert(stateButton)
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
