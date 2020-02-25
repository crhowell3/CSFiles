--[[
Run with either the iPhone X or the iPad Pro. iPad Pro provides a larger screen to see the balls better.
Author:   Cameron Howell

Class:    CS571 Spring 2020
Due Date: February 4, 2020
Email:    crh0043@uah.edu
]]

--Declarations for the csv file location AND the csv lua file for parsing the car.csv data
local csv = require("csv")
local f = csv.open(system.pathForFile( "car.csv", system.ResourceDirectory))

local balls={}
local ballRadius = 0
local carType = ""
local carName = ""
local speed = 0

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
  local ball = display.newCircle( math.random(ballRadius + 5, display.contentWidth - ballRadius - 5), math.random(ballRadius + 5, display.contentHeight - ballRadius - 5), ballRadius )
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
    if ball.y + ball.deltaY > display.contentHeight - ball.ballRadius or ball.y + ball.deltaY < ballRadius then
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
