--[[
This is the opening scene that shows the country overlay. Contains all 50 states represented as tappable squares.
NOTE: I cannot show the recoveries, as that data was not given in daily increments. I could show an overview of the recoveries in terms of the
entire country, but that would not fit with the time scale.
]]
local composer = require( "composer" )
local scene = composer.newScene()
local State = require ("state")
local stateObjTable
local gridX = 500
local gridY = 100
local stateGrid = {{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                   {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1},
                   {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                   {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
                   {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
                   {0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
                   {0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
                   {1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0}}
local stateList = {"Maine", ""}
local stateCounter = 1

local function sliderListener(event)
--For the slider that will control the dates
end

function scene:create(event)
  local sceneGroup = self.view
  local params = event.params
  stateObjTable = params.sot
  display.setDefault("background", 208/255, 200/255, 189/255)
  local title = display.newText(
    {
      text = "Test",
      fontSize = 50,
      x = display.contentCenterX,
      y = display.contentCenterY,
    }
  )
  for i=1,8 do
    for j=1,12 do
      if (stateGrid[i][j] == 1) then
        stateObjTable[stateCounter].xPos = gridX
        stateObjTable[stateCounter].yPos = gridY
        stateObjTable[stateCounter]:spawn()
        gridX = gridX + 125
        stateCounter = stateCounter + 1
      else
        gridX = gridX + 125
      end
    end
    gridX = 500
    gridY = gridY + 125
  end
  --[[
  for _, p in ipairs(stateObjTable) do
    p.xPos = gridX
    p.yPos = gridY
    gridX = gridX + 125
    if(gridX == 1300) then
      gridX = 300
      gridY = gridY + 125
    end
    p.r = 1
    p.b = 1
    p.g = 1
    p:spawn()
  end
  ]]
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
