--[[
This is the scene that shows whenever a state is tapped into, and it shows county-level details about the state, as well as total numbers.
NOTE: I cannot show recoveries for either the states or the counties because that data was not made avaibable in daily increments.
]]
local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )

local function sliderListener(event)
  if (event.target.id == "date") then
    if (event.value > 98) then
      dateBox.text = dateList[98]
    elseif (event.value == 0) then
      dateBox.text = dateList[1]
    else
      dateBox.text = dateList[event.value]
    end
  end
end

function scene:create(event)
  local sceneGroup = self.view
  local params = event.params
  stateObjTable = params.st
  dateList = params.dl
  date = params.d
  display.setDefault("background", 208/255, 200/255, 189/255)
  dateSlider = widget.newSlider(
    {
        id = "date",
        x = 150,
        y = display.contentCenterY,
        height = 400,
        value = date,
        frameWidth = 15,
        handleWidth = 70,
        handleHeight = 70,
        orientation = "vertical",
        listener = sliderListener
    }
  )
  dateBox = display.newText(
    {
        text = dateList[date],
        fontSize = 50,
        x = dateSlider.x + 150,
        y = dateSlider.y + 200,
    }
  )
  countyBox = native.newTextBox( display.contentCenterX, display.contentCenterY, 100, 100 )
  sceneGroup:insert(dateSlider)
  sceneGroup:insert(dateBox)
end

function scene:show(event)
  composer.removeScene("countryScene")
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
