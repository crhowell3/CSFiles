local composer = require( "composer" )
local scene = composer.newScene()

local numberObject = {}

local grid = {}
for i=1,4 do
  grid[i] = {}
end

local counter = 3

local function onGameEnd(event)
  local options = {
    effect = "fade",
    time = 800
  }
  composer.gotoScene("result", options)
end

local function changeNumberToBox(n)
  n.text.isVisible = false
  n.isVisible = true
end

local function onBoxClick(event)
  if event.target.isClicked == false then
    local right = audio.loadSound( "sounds/right.mp3" )
    local audioChannel = audio.play( right )
    event.target.isClicked = true
    event.target.isVisible = false
    event.target.text.isVisible = true
  end
end

local function updateStage(event)
  local number = display.newText(
    {
      text = math.random(1, 10),
      x = math.random(100, display.contentWidth - 100),
      y = math.random(100, display.contentWidth - 100),
      font = "fonts/Montserrat-Medium",
      fontSize = 125
    }
  )
  local box = display.newRect( number.x, number.y, 100, 100 )
  box.isVisible = false
  box.isClicked = false
  box.text = number
  table.insert(numberObject, box)
  box:addEventListener("tap", onBoxClick)
end

function scene:create(event)
  local sceneGroup = self.view
end

function scene:show(event)
  local sceneGroup = self.view
  local green = {101/255, 204/255, 184/255}
  local phase = event.phase
  if (phase == "will") then
    display.setDefault( "background", unpack(green) )
    for i=1, counter do
      updateStage()
    end
  elseif (phase == "did") then
    for _, i in ipairs(numberObject) do
      timer.performWithDelay( 700, changeNumberToBox(i))
    end
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
