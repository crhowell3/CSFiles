--[[
Author: Cameron Howell
Class: CS 571 Spring 2020
Assignment: Final Exam App
Device: This program was made using the iPhone 6+ prefab in Corona SDK
Purpose: This program displays real-time COVID-19 data through web scraping
]]
local countryTableList
local countryList
local stateTableList

local http = require( "socket.http" )
local body, statusCode, headers, statusText = http.request('https://bing.com/covid/data')

local json = require( "json" )
local decode = json.decode( body )
for index, value in pairs( decode ) do
  if ( index == "areas" ) then
    countryTableList = value
    break
  end
end

for index, value in pairs( countryTableList ) do
  if ( index == 1 ) then
    countryList = value
    break
  end
end

for index, value in pairs( countryList ) do
  if ( index == "areas" ) then
    stateTableList = value
    break
  end
end

local composer = require( "composer" )
local options = {
  effect = "fade",
  time = 800,
  params = {
    st = stateTableList
  }
}
--hides the iPhone's status bar
--display.setStatusBar(display.HiddenStatusBar)

--loads the title scene
composer.gotoScene( "stateScene", options )
