--[[
***BUILT ON THE IPHONE X***
Author:   Cameron Howell
Class:    CS571 Spring 2020
Due Date: February 26, 2020
Email:    crh0043@uah.edu
]]

--Declarations for the csv file location AND the csv lua file for parsing the car.csv data
local csv = require("csv")
local f = csv.open(system.pathForFile( "car.csv", system.ResourceDirectory))
local widget = require("widget")

local balls={}
local ballRadius = 0
local carType = ""
local carName = ""
local speed = 0

--Creates the rounded rectangle GUI component
local menu = display.newRoundedRect( display.contentWidth / 2, display.contentHeight - 375, display.contentWidth, 750, 25)
menu:setFillColor(0.2, 0.2, 0.2)

--[[The clearBall function is event-based. When a ball object is touched, this event is triggered.
The ball object is first removed from the balls table, then removed from the screen. The
text associated with the ball object is removed from the display as well.]]
local function clearBall(event)
  for k,v in pairs(balls) do
        if v == event.target then table.remove(balls, k) end
    end
  event.target:removeSelf()
  display.remove(event.target.text)
end

--[[This createBall function uses the values from the csv file to specify the parameters, i.e.
the radius, color, speed, and text. All balls are created at a random location that is bounded
and padded to prevent a ball from being spawned offscreen, which would cause it to glitch around
the edge. The randomness of the ball direction is determined by multiplying the speed by either a
positive or negative 1 at random.]]
local function createBall()
  local ball = display.newCircle( math.random(ballRadius + 5, display.contentWidth - ballRadius - 5), math.random(ballRadius + 5, display.contentHeight - ballRadius - 750), ballRadius )
  if carType == "Small" then
    ball:setFillColor(0, 1, 0)
  elseif carType == "Sporty" then
    ball:setFillColor(1, 0, .498)
  elseif carType == "Compact" then
    ball:setFillColor(0, 0, 1)
  elseif carType == "Medium" then
    ball:setFillColor(.30, .30, .30)
  elseif carType == "Large" then
    ball:setFillColor(1, 0, 0)
  elseif carType == "Van" then
    ball:setFillColor(1, 1, 0)
  end
  ball.deltaX = ((speed / 3) * ((math.random(1,2)*2)-3))
  ball.deltaY = ((speed / 3) * ((math.random(1,2)*2)-3))
  ball.ballRadius = ballRadius
  local text = display.newText(carName, ball.x, ball.y, native.systemFont, 40)
  ball.text = text
  table.insert(balls, ball)
  ball:addEventListener("touch", clearBall)
end

local function onSwitchPress(event)
  local switch = event.target
end

--CHECKBOX BEGIN
local options = {
  width = 99,
  height = 94,
  numFrames = 2,
  sheetContentWidth = 198,
  sheetContentHeight = 94
}
local checkboxSheet = graphics.newImageSheet( "checkbox.png", options )
local checkbox1 = widget.newSwitch(
  {
    left = 50,
    top = display.contentHeight - 700,
    style = "checkbox",
    id = "Small",
    width = 100,
    height = 100,
    initialSwitchState = true,
    onPress = onSwitchPress,
    sheet = checkboxSheet,
    frameOff = 1,
    frameOn = 2
  }
)
local checkText1 = display.newText("Small", checkbox1.x + 50, checkbox1.y, native.systemFont, 55)
checkText1.anchorX = 0

local checkbox2 = widget.newSwitch(
  {
    left = 50,
    top = display.contentHeight - 600,
    style = "checkbox",
    id = "Sporty",
    width = 100,
    height = 100,
    initialSwitchState = true,
    onPress = onSwitchPress,
    sheet = checkboxSheet,
    frameOff = 1,
    frameOn = 2
  }
)
local checkText2 = display.newText("Sporty", checkbox2.x + 50, checkbox2.y, native.systemFont, 55)
checkText2.anchorX = 0

local checkbox3 = widget.newSwitch(
  {
    left = 50,
    top = display.contentHeight - 500,
    style = "checkbox",
    id = "Compact",
    width = 100,
    height = 100,
    initialSwitchState = true,
    onPress = onSwitchPress,
    sheet = checkboxSheet,
    frameOff = 1,
    frameOn = 2
  }
)
local checkText3 = display.newText("Compact", checkbox3.x + 50, checkbox3.y, native.systemFont, 55)
checkText3.anchorX = 0

local checkbox4 = widget.newSwitch(
  {
    left = 50,
    top = display.contentHeight - 400,
    style = "checkbox",
    id = "Medium",
    width = 100,
    height = 100,
    initialSwitchState = true,
    onPress = onSwitchPress,
    sheet = checkboxSheet,
    frameOff = 1,
    frameOn = 2
  }
)
local checkText4 = display.newText("Medium", checkbox4.x + 50, checkbox4.y, native.systemFont, 55)
checkText4.anchorX = 0

local checkbox5 = widget.newSwitch(
  {
    left = 50,
    top = display.contentHeight - 300,
    style = "checkbox",
    id = "Large",
    width = 100,
    height = 100,
    initialSwitchState = true,
    onPress = onSwitchPress,
    sheet = checkboxSheet,
    frameOff = 1,
    frameOn = 2
  }
)
local checkText5 = display.newText("Large", checkbox5.x + 50, checkbox5.y, native.systemFont, 55)
checkText5.anchorX = 0

local checkbox6 = widget.newSwitch(
  {
    left = 50,
    top = display.contentHeight - 200,
    style = "checkbox",
    id = "Van",
    width = 100,
    height = 100,
    initialSwitchState = true,
    onPress = onSwitchPress,
    sheet = checkboxSheet,
    frameOff = 1,
    frameOn = 2
  }
)
local checkText6 = display.newText("Van", checkbox6.x + 50, checkbox6.y, native.systemFont, 55)
checkText6.anchorX = 0
--CHECKBOX END

--RADIO BEGIN
local radioGroup = display.newGroup()

local options = {
  width = 100,
  height = 99,
  numFrames = 2,
  sheetContentWidth = 200,
  sheetContentHeight = 99
}

local radioSheet = graphics.newImageSheet("radio.png", options)
local radioButton1 = widget.newSwitch(
  {
    left = 450,
    top = display.contentHeight - 700,
    style = "radio",
    id = "RadioButton1",
    width = 100,
    height = 100,
    initialSwitchState = true,
    onPress = onSwitchPress,
    sheet = radioSheet,
    frameOff = 1,
    frameOn = 2
  }
)
radioGroup:insert(radioButton1)
local radioText1 = display.newText("Weight", radioButton1.x + 50, radioButton1.y, native.systemFont, 55)
radioText1.anchorX = 0

local radioButton2 = widget.newSwitch(
  {
    left = 750,
    top = display.contentHeight - 700,
    style = "radio",
    id = "RadioButton2",
    width = 100,
    height = 100,
    onPress = onSwitchPress,
    sheet = radioSheet,
    frameOff = 1,
    frameOn = 2
  }
)
radioGroup:insert(radioButton2)
local radioText2 = display.newText("Mileage", radioButton2.x + 50, radioButton2.y, native.systemFont, 55)
radioText2.anchorX = 0
--RADIO END

--TEXTBOX BEGIN
local defaultBox
local function textListener(event)
    if ( event.phase == "began") then
      --begin editing
    elseif (event.phase == "ended" or event.phase == "submitted") then
      --after editing
    elseif (event.phase == "editing") then
      --while editing
    end
  end
  defaultBox = native.newTextField(475, display.contentHeight - 200, 600, 100)
  defaultBox.anchorX = 0;
  defaultBox.isEditable = true
  defaultBox:addEventListener("userInput", textListener)
  defaultBox.isFontSizeScaled = true
  defaultBox.size = 50
--TEXTBOX END

--SLIDER BEGIN
local function sliderListener(event)

end

local slider = widget.newSlider(
  {
    id = "min",
    left = 475,
    top = display.contentHeight - 550,
    width = 600,
    value = 10,
    listener = sliderListener
  }
)
--SLIDER END

--[[This massive for loop opens the csv file, checks the values at each x,y, and then
sets those values to a variable that will define the ball. After reading through
an entire row, the loop calls the createBall() function. This for loop executes
until the file ends.]]
for fields in f:lines() do
  for i, v in ipairs(fields) do
    if i == 1 then
      if v ~= "Car" then
        carName = v
      end
    elseif i == 2 then
      if v ~= "Weight" then
        ballRadius = tonumber(v)
        ballRadius = ballRadius / 60
      end
    elseif i == 4 then
      if v ~= "Mileage" then
        speed = tonumber(v)
      end
    elseif i == 6 then
      if v ~= "Type" then
        carType = v
        createBall()
      end
    end
  end
end

--[[The update function is run every 15 milliseconds to calculate each ball's new position according to
their current speed and position. This function also simultaneously updates the text's position to align
with the new position of its respective ball.]]
local function update()
  for _, ball in ipairs(balls) do
    if ball.x + ball.deltaX > display.contentWidth - ball.ballRadius or ball.x + ball.deltaX < ballRadius then
      ball.deltaX = -ball.deltaX
    end
    if ball.y + ball.deltaY > display.contentHeight - ball.ballRadius - 750 or ball.y + ball.deltaY < ballRadius then
      ball.deltaY = -ball.deltaY
    end
    ball.text.x = ball.text.x + ball.deltaX
    ball.text.y = ball.text.y + ball.deltaY
    ball.x = ball.x + ball.deltaX
    ball.y = ball.y + ball.deltaY
  end
end

--Runs the update function at a set rate of 15 milliseconds
timer.performWithDelay( 15, update, 0 )
