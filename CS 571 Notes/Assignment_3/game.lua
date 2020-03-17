local composer = require( "composer" )
local scene = composer.newScene()

local function onGameEnd(event)
  local options = {
    effect = "fade",
    time = 800
  }
  composer.gotoScene("result", options)
end

local function changeNumberToBox(event)
  sceneGroup.numberObject.number.isVisible = false
end

local numberObject = display.newGroup()

function scene:create(event)
  local sceneGroup = self.view
  local number = display.newText(
    {
      text = math.random(1, 10),
      x = display.contentWidth / 2,
      y = display.contentHeight / 2 - 50,
      font = "Montserrat-Medium",
      fontSize = 125
    }
  )
  local box = display.newRect( number.x, number.y, 100, 100 )
  box.isVisible = false
  numberObject:insert(number)
  numberObject:insert(box)
  sceneGroup:insert(numberObject)
end

function scene:show(event)
  local sceneGroup = self.view
  sceneGroup:addEventListener("")
  local green = {101/255, 204/255, 184/255}
  local phase = event.phase
  if (phase == "will") then
    display.setDefault( "background", unpack(green) )
  elseif (phase == "did") then
    timer.performWithDelay( 700, changeNumberToBox, 0 )
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
