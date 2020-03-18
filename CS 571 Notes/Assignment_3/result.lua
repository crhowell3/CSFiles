local composer = require( "composer" )
local scene = composer.newScene()

local eggshell = {242/255, 242/255, 242/255}
local charcoal = {24/255, 38/255, 40/255}
local forest = {59/255, 148/255, 94/255}
local green = {101/255, 204/255, 184/255}

local score = 0
local achieved = 0

local function returnToMenu(event)
  local options = {
    effect = "fade",
    timer = 800
  }
  composer.removeScene("result")
  Runtime:removeEventListener("tap", returnToMenu)
  composer.gotoScene("title", options)
end

function scene:create(event)
  local sceneGroup = self.view
  local params = event.params
  score = params.s
  achieved = params.a
  local scoreLabel = display.newText(
    {
      text = "Score: ".. score,
      x = display.contentCenterX,
      y = display.contentCenterY,
      font = "fonts/Montserrat-Medium",
      fontSize = 125
    }
  )
  scoreLabel:setFillColor(unpack( charcoal ))

  local roundsPassed = display.newText(
    {
      text = "Passed ".. achieved .." rounds!",
      x = display.contentCenterX,
      y = display.contentCenterY + 125,
      font = "fonts/Montserrat-Medium",
      fontSize = 75
    }
  )
  if (achieved == 1) then
    roundsPassed.text = "Passed ".. achieved .." round!"
  end
  roundsPassed:setFillColor(unpack( charcoal ))
  sceneGroup:insert(scoreLabel)
  sceneGroup:insert(roundsPassed)
end

function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase
  if phase == "will" then
    display.setDefault( "background", unpack(green))
  elseif phase == "did" then
    Runtime:addEventListener("tap", returnToMenu)
    local gameOver = audio.loadSound("sounds/smb_world_clear.wav")
    local audioChannel3 = audio.play(gameOver)
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
