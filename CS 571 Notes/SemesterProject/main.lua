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
local caseArray = {}
local dailyCases = {}
local deathArray = {}
local dailyDeaths = {}
local ignoreFirstLine = 0
local stateName = ""
local dateList = {}
local maxCasesTbl = {}
local maxDeathsTbl = {}

--Iterate once to initialize the state objects with names
for fields in c:lines() do
  for i, v in ipairs( fields ) do
    if (ignoreFirstLine == 0 and i >= 12 and i <= 109) then
      table.insert(dateList, v)
    end
    if (i == 7 and ignoreFirstLine ~= 0) then
      if (v ~= stateName) then
        stateName = v
        local state = stateSquare:new({name = stateName, counties = {}, casesByDay = {}})
        table.insert(stateObjTable, state)
      end
    end
  end
  ignoreFirstLine = ignoreFirstLine + 1
end

--Iterate again to get the rest of the case data for each state
ignoreFirstLine = 0
counter = 1
for fields in c:lines() do
  for i, v in ipairs( fields ) do
    if (i == 6 and ignoreFirstLine ~= 0) then
      countyName = v
    elseif (i == 7 and ignoreFirstLine ~= 0) then
      for n, s in ipairs( stateObjTable ) do
        if ( v == s.name) then
          if (stateName ~= v) then
            counter = 1
          end
          stateName = s.name
        end
      end
    elseif ( i >= 12 and i <= 109 and ignoreFirstLine ~= 0) then
      caseArray[i-11] = v
      if (i == 109) then
        for n, s in ipairs( stateObjTable ) do
          if ( stateName == s.name ) then
            local county = {name = countyName, cases = caseArray, deaths = {}}
            s.counties[counter] = county
            counter = counter + 1
            county = nil
            caseArray = {}
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
        end
      end
    elseif (i >= 12 and i <= 109 and ignoreFirstLine ~= 0) then
      deathArray[i-11] = v
      if(i == 109) then
        for n, s in ipairs( stateObjTable ) do
          if (stateName == s.name) then
            for p, t in ipairs(s.counties) do
              if (countyName == t.name) then
                for i=1,#deathArray do
                  t.deaths[i] = deathArray[i]
                end
                deathArray = {}
              end
            end
          end
        end
      end
    end
  end
  ignoreFirstLine = ignoreFirstLine + 1
end

local sum = 0
for _, a in ipairs(stateObjTable) do
  for i=1,98 do
    for j=1,#a.counties do
      sum = sum + a.counties[j].cases[i]
    end
    a.casesByDay[i] = sum
    sum = 0
  end
end

local sum = 0
for _, a in ipairs(stateObjTable) do
  for i=1,98 do
    for j=1,#a.counties do
      sum = sum + a.counties[j].deaths[i]
    end
    a.deathsByDay[i] = sum
    sum = 0
  end
end

for _, s in ipairs(stateObjTable) do
  if (s.name == "Alabama") then
    for a, b in ipairs(s.counties) do
      for i, j in ipairs(b.deaths) do
        print(j)
      end
    end
  end
end

for i=1,50 do
  maxCasesTbl[i] = stateObjTable[i].casesByDay[98]
  maxDeathsTbl[i] = stateObjTable[i].deathsByDay[98]
end

local options = {
  effect = "fade",
  time = 800,
  params = {
    sot = stateObjTable,
    dat = dateList,
    mc = maxCasesTbl,
    md = maxDeathsTbl
  }
}

display.setStatusBar( display.HiddenStatusBar )

composer.gotoScene( "countryScene", options )
