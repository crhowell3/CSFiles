local composer = require( "composer" )
local scene = composer.newScene()

function scene:create(event)
  display.setDefault( "background", 1, 1, 0 )
  local sceneGroup = self.view
end

function scene:show(event)

end

function scene:hide(event)

end

function scene:destroy(event)
  local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
