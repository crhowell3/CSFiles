local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")
local State = require ("state")

local stateSquare = State:new()
local stateList
local selectedState = nil
local stateObjTable = {}
local toggle = false
local gridX = 300
local gridY = 300

local function onClick(event)
  local options = {
    effect = "fade",
    time = 800,
    params = {
      st = stateList,
      sel = selectedState
    }
  }
  if (selectedState ~= nil) then
    composer.gotoScene("countyScene", options)
  end
end

function stateSquare:spawn()
  self.shape = display.newRect( self.xPos, self.yPos, 100, 100 );
  self.shape.pp = self;
  self.shape:setFillColor(self.r, self.g, self.b);
end

function stateSquare:touch(g)
  local function onStateTouch (event)
    for _, k in ipairs(stateObjTable) do
      k.shape.strokeWidth = 0
      k.isSelected = false
      toggle = false
      k:display()
    end
    event.target.strokeWidth = 7
    event.target.isSelected = true
    toggle = true
    selectedState = self
    self:display(g)
  end
  self.shape:addEventListener("tap", onStateTouch);
end

function stateSquare:display(g)
  if (toggle == true) then
    local nameText = display.newText(
      {
        text = self.name,
        fontSize = 125,
        x = display.contentCenterX,
        y = display.contentHeight - 100
      }
    )
    self.title = nameText
    g:insert(self.title);
  else
    display.remove(self.title)
  end
end

function scene:create(event)
  local sceneGroup = self.view
  local params = event.params
  stateList = params.st
  local options = {
    x = display.contentWidth - 150,
    y = 100,
    width = 100,
    height = 50
  }
  local countyButton = widget.newButton( options )
  countyButton.anchorX = 0.5
  countyButton.anchorY = 0.5
  local text = display.newText(
    {
      text = "County >",
      fontSize = 50
    }
  )
  text.x = countyButton.x
  text.y = countyButton.y
  countyButton.text = text
  countyButton:addEventListener("tap", onClick)
  countyButton.isVisible = true

  for index, value in pairs(stateList) do
    local stateName
    local cList
    local create = true
    for field, fVal in pairs(value) do
      if (field == "displayName") then
        if (fVal == "District of Columbia") then
          create = false
        end
        stateName = fVal
      elseif (field == "areas") then
        cList = fVal
      end
    end
    if (create) then
      local state = stateSquare:new({counties = cList, name = stateName, xPos = gridX, yPos = gridY, r = math.random(), g = math.random(), b = math.random() })
      gridX = gridX + 125
      if(gridX == 925) then
        gridX = 300
        gridY = gridY + 125
      end
      state:spawn();
      state:touch(sceneGroup);
      table.insert(stateObjTable, state);
      sceneGroup:insert(state.shape);
    end
  end
  sceneGroup:insert(countyButton)
  sceneGroup:insert(text)
end

function scene:show(event)
  composer.removeScene("countyScene")
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
