--[[
****
****
*******NOTE******* THIS SCENE IS A DUMMY SCENE FOR RESETTING THE GAME SCENE
****
****
]]

local composer = require( "composer" )
local scene = composer.newScene()


function scene:create(event)
  local sceneGroup = self.view
end

function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase
  local p = event.params
  local green = {101/255, 204/255, 184/255}
  if phase == "will" then
    display.setDefault( "background", unpack(green))
  elseif phase == "did" then
    local options = {
      effect = "fade",
      timer = 800,
      params = {
        c = p.c,
        r = p.r,
        s = p.s,
        a = p.a
      }
    }
    composer.gotoScene( "game", options)
  end
end

function scene:hide(event)
  local sceneGroup = self.view
end

function scene:destroy(event)
  local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
