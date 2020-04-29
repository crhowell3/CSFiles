--[[
Author: Cameron Howell
Class: CS 571 Spring 2020
Assignment: Semester Project App
Device: This program was made using the iPhone X prefab in Corona SDK
Purpose: This program displays US COVID-19 data ranging from 1/22/20 to 4/28/20
]]
local csv = require("csv")
local c = csv.open(system.pathForFile( "confirmed.csv", system.ResourceDirectory ))
local d = csv.open(system.pathForFile( "deaths.csv", system.ResourceDirectory ))

for fields in c:lines() do
  for i, v in ipairs( fields ) do
    if (i >= 12 and i <= 109) then

    end
  end
end

for fields in d:lines() do
  for i, v in ipairs( fields ) do
    if (i >= 12 and i <= 109) then

    end
  end
end

--composer.gotoScene( "stateScene", options )
