--[[
This is just the base code for assignment #1. Finish this and submit by February 4th.
Author: Cameron Howell
Class: CS571 Spring 2020
Date: January 28, 2020
Email: crh0043@uah.edu
]]

local balls={}
local deltaX= 10
local deltaY= -deltaX
local ballRadius = 25

local function setFillColorRandom(obj)
  obj:setFillColor(math.random(), math.random(), math.random())
end

local function stopBall(event)
  event.target.stopped = not event.target.stopped
  return true
end

local function createBall(event)
  local ball = display.newCircle( display.contentCenterX, display.contentCenterY, ballRadius )
  setFillColorRandom(ball)
  ball.deltaX = deltaX
  ball.deltaY = deltaY
  ball.ballRadius = ballRadius
  table.insert(balls, ball)
  ball:addEventListener("tap", stopBall)
end

Runtime:addEventListener("tap", createBall)

local function update()
  for _, ball in ipairs(balls) do
    if not ball.stopped then
      if ball.x + ball.deltaX > display.contentWidth - ball.ballRadius or ball.x + ball.deltaX < ballRadius then
        ball.deltaX = -ball.deltaX
      end
      if ball.y + ball.deltaY > display.contentHeight - ball.ballRadius or ball.y + ball.deltaY < ballRadius then
        ball.deltaY = -ball.deltaY
      end

      ball.x = ball.x + ball.deltaX
      ball.y = ball.y + ball.deltaY
    end
  end
end

timer.performWithDelay( 15, update, 0 )
