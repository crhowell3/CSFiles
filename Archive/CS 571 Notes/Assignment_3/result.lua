--[[
The result scene shows the final score and the total number of rounds passed based
on values passed from the game scene
]]

local composer = require( "composer" )
local scene = composer.newScene()

local eggshell = {242/255, 242/255, 242/255}
local charcoal = {24/255, 38/255, 40/255}
local forest = {59/255, 148/255, 94/255}
local green = {101/255, 204/255, 184/255}

--Initialization for the score and rounds passed variables
local score = 0
local achieved = 0
--Dummy high score table
local highScores = {73, 64, 59, 42, 30}
local place = 1
local temp = 0

local function returnToMenu(event)
  local options = {
    effect = "fade",
    timer = 800
  }
  composer.removeScene("result")
--The Runtime eventListener must be removed, otherwise it will persist into the next scene and cause problems
  Runtime:removeEventListener("tap", returnToMenu)
  composer.gotoScene("title", options)
end

--The final score and rounds passed are set here after being pulled from the parameter
--list that was passed from the game scene
function scene:create(event)
  local sceneGroup = self.view
  local params = event.params
  score = params.s
  achieved = params.a
  table.insert(highScores, score)

  local function compare(a, b)
    return a > b
  end
  table.sort(highScores, compare)

  for i = #highScores, 6, -1 do
    table.remove(highScores, i)
  end

  local scoreLabel = display.newText(
    {
      text = "Score: ".. score,
      x = display.contentCenterX,
      y = display.contentCenterY - 125,
      font = "fonts/Montserrat-Medium",
      fontSize = 125
    }
  )
  scoreLabel:setFillColor(unpack( charcoal ))

  local roundsPassed = display.newText(
    {
      text = "Passed ".. achieved .." rounds!",
      x = display.contentCenterX,
      y = display.contentCenterY,
      font = "fonts/Montserrat-Medium",
      fontSize = 75
    }
  )
  --If there was only one round passed, this is dispayed instead for grammar purposes
  if (achieved == 1) then
    roundsPassed.text = "Passed ".. achieved .." round!"
  end

  local highScoreTitle = display.newText(
    {
      text = "Top 5 Scores:",
      x = display.contentCenterX,
      y = display.contentCenterY + 100,
      font = "fonts/Montserrat-Medium",
      fontSize = 60
    }
  )

  for i=1, 5 do
    if highScores[i] then
      local yPos = display.contentCenterY + 150 + (i * 75)
      local thisScore = display.newText(
        {
            parent = sceneGroup,
            text = highScores[i],
            x = display.contentCenterX,
            y = yPos,
            font = "fonts/Montserrat-Medium",
            fontSize = 60
        }
      )
      if tonumber(thisScore.text) == score then
        thisScore:setFillColor(unpack(eggshell))
      else
        thisScore:setFillColor(unpack(charcoal))
      end
    end
  end
  roundsPassed:setFillColor(unpack( charcoal ))
  highScoreTitle:setFillColor(unpack(charcoal))
  sceneGroup:insert(scoreLabel)
  sceneGroup:insert(roundsPassed)
  sceneGroup:insert(highScoreTitle)
end

--Plays the winning audio sound and adds a Runtime event listener for returning to the main menu
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
