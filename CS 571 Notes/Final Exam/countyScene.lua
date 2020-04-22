local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")
local County = require ("county")

local countyCircle = County:new()
local stateList
local selectedState
local toggle = false
local countyObjTable = {}
local gridX = 175
local gridY = 250
local max = 0
local min = 1000000000
local colorMax = 0
local colorMin = 10000000000

local event = {name="deltaAlert"}

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

local function onClick(event)
  local options = {
    effect = "fade",
    time = 800,
    params = {
      st = stateList
    }
  }
  composer.gotoScene("stateScene", options)
end

function countyCircle:spawn()
  self.shape = display.newCircle(self.xPos, self.yPos, self.radius)
  self.shape.pp = self;
  self.shape:setFillColor(self.r, self.g, self.b, self.a);
  self.shape.strokeWidth = 5
end

function countyCircle:touch(g)
  local function onCountyTouch (event)
    for _, k in ipairs(countyObjTable) do
      k.shape.strokeWidth = 5
      k.isSelected = false
      toggle = false
      k:display(g)
    end
    event.target.strokeWidth = 10
    event.target.isSelected = true
    toggle = true
    self:display(g)
  end
  self.shape:addEventListener("tap", onCountyTouch)
end

function countyCircle:display(g)
  if (toggle == true) then
    local nameText = display.newText(
      {
        text = self.name .. '\nDeaths: ' .. self.deaths .. '\nCases: ' .. self.confirmed,
        fontSize = 50,
        x = display.contentCenterX,
        y = display.contentHeight - 100
      }
    )
    self.title = nameText
    g:insert(self.title);
  else
    display.remove(self.title)
  end
  local function showAlert (event)
    local alert = display.newText(
      {
        text = "!",
        fontSize = 50,
        x = self.shape.x,
        y = self.shape.y
      }
    )
    alert:setTextColor(1, 1, 0, 1)
    self.al = alert
    g:insert(self.al)
  end
  self.shape:addEventListener("deltaAlert", showAlert)
  if(self.delta >= 500) then
    self.shape:dispatchEvent(event)
  end
end

function scene:create(event)
  local sceneGroup = self.view
  local params = event.params
  stateList = params.st
  selectedState = params.sel
  local options = {
    x = 150,
    y = 100,
    width = 200,
    height = 100
  }
  local stateButton = widget.newButton( options )
  stateButton.anchorX = 0.5
  stateButton.anchorY = 0.5
  local text = display.newText(
    {
      text = "< State",
      fontSize = 50
    }
  )
  text.x = stateButton.x
  text.y = stateButton.y
  stateButton.text = text
  sceneGroup:insert(text)
  stateButton:addEventListener("tap", onClick)
  --stateButton:addEventListener("tap", onClick)
  stateButton.isVisible = true

  local temp = {}
  local colorTemp = {}
  for j, l in pairs(selectedState.counties) do
    for f, c in pairs(l) do
      if (f == "totalConfirmed") then
        table.insert(temp, tonumber(c))
      elseif (f == "totalDeaths") then
        table.insert(colorTemp, tonumber(c))
      end
    end
  end
  table.sort(temp)
  max = temp[#temp]
  min = temp[1]

  table.sort(colorTemp)
  colorMax = colorTemp[#colorTemp]
  colorMin = colorTemp[1]

  local counter = 0
  for i, v in pairs(selectedState.counties) do
    if (counter == 100) then
      break
    end
    local countyName
    local d = 0
    local c = 0
    local del = 0
    for field, countyData in pairs(v) do
      if (field == "displayName") then
        countyName = countyData
      elseif (field == "totalDeaths") then
        d = countyData
      elseif (field == "totalConfirmed") then
        c = countyData
      elseif (field == "totalConfirmedDelta") then
        del = countyData
      end
    end
    local cNum = tonumber( c )
    local mappedVal = map(cNum, min, max, 25, 60)
    local dNum = tonumber( d )
    local colorVal = map(dNum, colorMin, colorMax, 0, 255)
    local r,g,b,a = HSL(0, colorVal, 110, 0.5)
    local county = countyCircle:new({name = countyName, xPos = gridX, yPos = gridY, r = r, g = g, b = b, a = a, deaths = d, confirmed = c, radius = mappedVal, delta = del})
    gridX = gridX + 120
    if (gridX == 1015) then
      gridX = 175
      gridY = gridY + 100
    end
    county:spawn();
    county:touch(sceneGroup);
    county:display(sceneGroup);
    table.insert(countyObjTable, county);
    sceneGroup:insert(county.shape);
    counter = counter + 1
  end
  sceneGroup:insert(stateButton)
end

function scene:show(event)
  composer.removeScene("stateScene")
  local sceneGroup = self.view
  if (phase == "will") then
  elseif (phase == "did") then
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
