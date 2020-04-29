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
local State = require ("state")
local composer = require( "composer" )

local stateSquare = State:new()
local stateObjTable = {}
local countyName = ""
local cases = {}
local deaths = {}
local ignoreFirstLine = 0
local stateName = ""
local county = {name = "", cases = {}, deaths = {}}

function county:new (obj)
  obj = obj or {};
  setmetatable( obj, self );
  self.__index = self;
  return obj;
end

local countyObj = county:new()

--Iterate once to initialize the state objects with names
for fields in c:lines() do
  for i, v in ipairs( fields ) do
    if (i == 7 and ignoreFirstLine ~= 0) then
      if (v ~= stateName and v ~= "District of Columbia") then
        stateName = v
        local state = stateSquare:new({name = stateName})
        table.insert(stateObjTable, state)
      end
    end
  end
  ignoreFirstLine = ignoreFirstLine + 1
end

--Iterate again to get the rest of the case data for each state
ignoreFirstLine = 0
for fields in c:lines() do
  for i, v in ipairs( fields ) do
    if (i == 6 and ignoreFirstLine ~= 0) then
      countyName = v
    elseif (i == 7 and ignoreFirstLine ~= 0) then
      for n, s in ipairs( stateObjTable ) do
        if ( v == s.name) then
          stateName = s.name
          break
        end
      end
    elseif ( i >= 12 and i <= 109 and ignoreFirstLine ~= 0) then
      cases[i-11] = v
      if (i == 109) then
        for n, s in ipairs( stateObjTable ) do
          if ( stateName == s.name ) then
            local co = countyObj:new({name = countyName, cases = cases})
            table.insert(s.counties, co)
            break
          end
        end
      end
    end
  end
  ignoreFirstLine = ignoreFirstLine + 1
end

ignoreFirstLine = 0
for fields in d:lines() do
  for i, v in ipairs( fields ) do
    if (i == 6 and ignoreFirstLine ~= 0) then
      countyName = v
    elseif (i == 7 and ignoreFirstLine ~= 0) then
      for n, s in ipairs( stateObjTable ) do
        if ( v == s.name) then
          stateName = s.name
          break
        end
      end
    elseif (i >= 12 and i <= 109 and ignoreFirstLine ~= 0) then
      deaths[i-11] = v
      if(i == 109) then
        for n, s in ipairs( stateObjTable ) do
          if (stateName == s.name) then
            for p, t in ipairs(s.counties) do
              if (countyName == t.name) then
                t.deaths = deaths
              end
            end
            break
          end
        end
      end
    end
  end
  ignoreFirstLine = ignoreFirstLine + 1
end

local options = {
  effect = "fade",
  time = 800,
  params = {
    sot = stateObjTable
  }
}

display.setStatusBar( display.HiddenStatusBar )

composer.gotoScene( "countryScene", options )
