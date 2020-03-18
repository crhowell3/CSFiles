local composer = require( "composer" )
local scene = composer.newScene()

local numberObject = {}

local eggshell = {242/255, 242/255, 242/255}
local charcoal = {24/255, 38/255, 40/255}
local forest = {59/255, 148/255, 94/255}
local green = {101/255, 204/255, 184/255}

local grid = {}
for i=1,4 do
  grid[i] = {}
end

local usedNumbers = {}

local counter = 0
local round = 0
local score = 0
local achieved = 0
local check
local lose

local function onGameEnd(scr, ach)
  local options = {
    effect = "fade",
    time = 800,
    params = {
      s = scr,
      a = ach
    }
  }
  composer.removeScene("game")
  composer.gotoScene("result", options)
end

local function changeNumberToBox(n)
  n.text.isVisible = false
  n.isVisible = true
end

local function updateScene(cnt,rnd,scr,ach)
  local options = {
    effect = "fade",
    timer = 1500,
    params = {
      c = cnt,
      r = rnd,
      s = scr,
      a = ach
    }
  }
  for k, v in ipairs(grid) do
    v = {}
  end
  for _, i in ipairs(numberObject) do
    i = nil
  end
  for _, i in ipairs(usedNumbers) do
    i = nil
  end
  composer.removeScene( "game" )
  composer.gotoScene("intermediate", options)  --This intermediate scene is here for resetting the scene object. The intermediate scene contains nothing.
end

local function onBoxClick(event)
  local min = 13
  local max = 0
  local index = 0
  local count = 1
  for _, i in ipairs(usedNumbers) do
    if i < min then
      min = i
      index = count
    end
    if i > max then
      max = i
    end
    count = count + 1
  end
  if event.target.isClicked == false and tonumber(event.target.text.text) == min then
    local right = audio.loadSound( "sounds/right.mp3" )
    local audioChannel = audio.play( right )
    event.target.isClicked = true
    event.target.isVisible = false
    event.target.text.isVisible = true
    event.target.text:setFillColor(unpack( forest ))
    table.remove(usedNumbers, index)
    if tonumber(event.target.text.text) == max then
      local win = audio.loadSound( "sounds/win.mp3" )
      local audioChannel2 = audio.play( win )
      check.isVisible = true
      counter = counter + 1
      round = round + 1
      score = score + counter - 1
      achieved = achieved + 1
      if round > 10 then
        onGameEnd(score, achieved)
      else
        updateScene(counter, round, score, achieved)
      end
    end
  elseif event.target.isClicked == false and tonumber(event.target.text.text) ~= min then
    local wrong = audio.loadSound( "sounds/wrong.mp3" )
    local audioChannel = audio.play( wrong )
    if counter > 3 then
      counter = counter - 1
    end
    lose.isVisible = true
    round = round + 1
    if round > 10 then
      onGameEnd(score, achieved)
    else
     updateScene(counter, round, score, achieved)
    end
  end
end

local function createGameObject(xPos, yPos, sceneGroup)
  local randomNum = math.random(1, 12)
  --This while loop ensures that no numbers are repeated for any one stage
  while true do
    local changed = false
    for _, i in ipairs(usedNumbers) do
      if i == randomNum then
        randomNum = math.random(1, 12)
        changed = true
      end
    end
    if changed ~= true then
      table.insert(usedNumbers, randomNum)
      break
    end
  end

  local number = display.newText(
    {
      text = randomNum,
      font = "fonts/Montserrat-Medium",
      fontSize = 125
    }
  )
  number.x = (xPos - 1) * 150 + (150 * .5) + (display.contentCenterX - (450 * 0.5))
  number.y = (yPos - 1) * 150 + (150 * .5) + (display.contentCenterY - (600 * 0.5))
  local box = display.newRect( number.x, number.y, 100, 100 )
  box.isVisible = false
  box.isClicked = false
  box:setFillColor(unpack( eggshell ))
  box.text = number
  box.text:setFillColor(unpack(eggshell))
  box.text.isVisible = false
  table.insert(numberObject, box)
  box:addEventListener("tap", onBoxClick)
  sceneGroup:insert(box)
  sceneGroup:insert(number)
  return numberObject
end

function scene:create(event)
  local sceneGroup = self.view
  local params = event.params
  counter = params.c
  round = params.r
  score = params.s
  achieved = params.a
  for i=1, counter do
    local xPos = math.random(1, 3)
    local yPos = math.random(1, 4)
    while (grid[xPos][yPos] ~= nil) do
      xPos = math.random(1, 3)
      yPos = math.random(1, 4)
    end
    grid[xPos][yPos] = createGameObject(xPos, yPos, sceneGroup)
  end
  local roundLabel = display.newText(
    {
      text = "Round ".. round,
      x = display.contentCenterX,
      y = display.contentCenterY - 800,
      font = "fonts/Montserrat-Medium",
      fontSize = 125
    }
  )

  check = display.newImage("pictures/check-icon.png", display.contentCenterX, display.contentCenterY)
  check.anchorX = 0.5
  check.anchorY = 0.5
  check.isVisible = false

  lose = display.newImage("pictures/exit-button-icon-3.png", display.contentCenterX, display.contentCenterY)
  lose.anchorX = 0.5
  lose.anchorY = 0.5
  lose.isVisible = false

  sceneGroup:insert(check)
  sceneGroup:insert(lose)
  roundLabel:setFillColor(unpack( charcoal ))
  sceneGroup:insert(roundLabel)
end

function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase
  local params = event.params
  round = params.r
  if (phase == "will") then
    display.setDefault( "background", unpack(green) )
    for _, i in ipairs(numberObject) do
      i.text.isVisible = true
    end
  elseif (phase == "did") then
    for _, i in ipairs(numberObject) do
      timer.performWithDelay( 700, changeNumberToBox(i))
    end
  end
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
