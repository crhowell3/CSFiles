--[[
Author: Cameron Howell
Class: CS 571 Spring 2020
Assignment: Homework 3
Device: This program was made using the iPhone X prefab in Corona SDK
Purpose: This program is a brain training game with 10 stages that progress in difficulty
]]

--options table for the transition effect
local composer = require( "composer" )
local options = {
  effect = "fade",
  time = 800,
}
--hides the iPhone's status bar
display.setStatusBar(display.HiddenStatusBar)

--loads the title scene
composer.gotoScene( "title", options )
