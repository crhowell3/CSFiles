--[[
This is the opening scene that shows the country overlay. Contains all 50 states represented as tappable squares.
NOTE: I cannot show the recoveries, as that data was not given in daily increments. I could show an overview of the recoveries in terms of the
entire country, but that would not fit with the time scale.
]]
local composer = require( "composer" )
local scene = composer.newScene()
local State = require ("state")
local widget = require( "widget" )
local gridX = 500
local gridY = 100
--This is my solution for mapping the states... have a 2D binary table that represents the locations on the screen, and then have
--a list of the states in order from left to right, top to bottom so that the iteration can match the correct state to its location.
--Hey, it works! There's probably a streamlined solution for this, but this is the fastest one I could come up with on the fly.
local stateGrid = {{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                   {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1},
                   {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                   {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
                   {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
                   {0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
                   {0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
                   {1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0}}
local stateList = { "Maine", "Vermont", "New Hampshire", "Washington", "Idaho", "Montana", "North Dakota",
                    "Minnesota", "Illinois", "Wisconsin", "Michigan", "New York", "Rhode Island", "Massachusetts",
                    "Oregon", "Nevada", "Wyoming", "South Dakota", "Iowa", "Indiana", "Ohio", "Pennsylvania", "New Jersey",
                    "Connecticut", "California", "Utah", "Colorado", "Nebraska", "Missouri", "Kentucky", "West Virginia",
                    "Virginia", "Maryland", "Delaware", "Arizona", "New Mexico", "Kansas", "Arkansas", "Tennessee", "North Carolina",
                    "South Carolina", "District of Columbia", "Oklahoma", "Louisiana", "Mississippi", "Alabama", "Georgia", "Alaska",
                    "Hawaii", "Texas", "Florida"}
local stateCounter = 1

--Using the functions from the final exam because they happen to work perfectly for this project
local function map(value, istart, istop, ostart, ostop)
  return (ostart + (ostop - ostart) * ((value - istart) / (istop - istart)))
end

function HSL(h, s, l, a)
  if s<=0 then return l,l,l,a end
  h, s, l = h/256*6, s/255, l/255
  local c = (1-math.abs(2*l-1))*s
  local x = (1-math.abs(h%2-1))*c
  local m,r,g,b = (l-.5*c), 0,0,0
  if h < 1     then r,g,b = c,x,0
  elseif h < 2 then r,g,b = x,c,0
  elseif h < 3 then r,g,b = 0,c,x
  elseif h < 4 then r,g,b = 0,x,c
  elseif h < 5 then r,g,b = x,0,c
  else              r,g,b = c,0,x
  end
  return (r+m),(g+m),(b+m),a
end

function State:touch(g, tbl, list)
  local function onStateTouch (event)
    if (event.numTaps == 1) then
      for _, k in ipairs(tbl) do
        k.shape.strokeWidth = 0
        k.isSelected = false
        toggle = false
        k:display()
      end
      event.target.strokeWidth = 10
      event.target.isSelected = true
      toggle = true
      selectedState = self
      self:display(g)
    elseif (event.numTaps == 2) then
      local options = {
        effect = "fade",
        time = 800,
        params = {
          st = tbl,
          dl = list,
          d = dateSlider.value
        }
      }
      if (selectedState ~= nil) then
        composer.gotoScene("stateScene", options)
      end
    end
  end
  self.shape:addEventListener("tap", onStateTouch);
end

local function sliderListener(event)
  if (event.target.id == "date") then
    if (event.value > 98) then
      dateBox.text = dateList[98]
    elseif (event.value == 0) then
      dateBox.text = dateList[1]
    else
      dateBox.text = dateList[event.value]
    end

    for _, p in ipairs(stateObjTable) do
      if (event.value == 0) then
        local colorVal = map(p.casesByDay[1], 0, maxDeathsTbl[#maxDeathsTbl], 0, 255)
        local r, g, b, a = HSL(0, colorVal, 110, 1)
        p.shape:setFillColor(r,g,b)
      elseif (event.value > 98) then
        local colorVal = map(p.casesByDay[98], 0, maxDeathsTbl[#maxDeathsTbl], 0, 255)
        local r, g, b, a = HSL(0, colorVal, 110, 1)
        p.shape:setFillColor(r,g,b)
      else
        local colorVal = map(p.casesByDay[event.value], 0, maxDeathsTbl[#maxDeathsTbl], 0, 255)
        local r, g, b, a = HSL(0, colorVal, 110, 1)
        p.shape:setFillColor(r,g,b)
      end
    end
  end
end

local function compare( a, b )
    return a < b
end

function scene:create(event)
  local sceneGroup = self.view
  local params = event.params
  stateObjTable = params.sot
  dateList = params.dat
  maxCasesTbl = params.mc
  table.sort(maxCasesTbl, compare)
  maxDeathsTbl = params.md
  table.sort(maxDeathsTbl, compare)
  display.setDefault("background", 208/255, 200/255, 189/255)
  dateSlider = widget.newSlider(
    {
        id = "date",
        x = 150,
        y = display.contentCenterY,
        height = 400,
        value = 0,
        frameWidth = 15,
        handleWidth = 70,
        handleHeight = 70,
        orientation = "vertical",
        listener = sliderListener
    }
  )
  sceneGroup:insert(dateSlider)
  dateBox = display.newText(
    {
        text = dateList[1],
        fontSize = 50,
        x = dateSlider.x + 150,
        y = dateSlider.y + 200,
    }
  )
  sceneGroup:insert(dateBox)
  for i=1,8 do
    for j=1,12 do
      if (stateGrid[i][j] == 1) then
        for _, s in ipairs(stateObjTable) do
          if (s.name == stateList[stateCounter]) then
            s.xPos = gridX
            s.yPos = gridY
            local colorVal = map(s.casesByDay[1], 0, maxDeathsTbl[#maxDeathsTbl], 0, 255)
            local r, g, b, a = HSL(0, colorVal, 110, 1)
            s.r = r
            s.g = g
            s.b = b
            s:spawn()
            s:touch(sceneGroup, stateObjTable, dateList)
            sceneGroup:insert(s.shape)
            gridX = gridX + 125
            stateCounter = stateCounter + 1
            break
          end
        end
      else
        gridX = gridX + 125
      end
    end
    gridX = 500
    gridY = gridY + 125
  end
end

function scene:show(event)
  composer.removeScene("stateScene")
  local sceneGroup = self.view
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
