--[[
This is the scene that shows whenever a state is tapped into, and it shows county-level details about the state, as well as total numbers.
NOTE: I cannot show recoveries for either the states or the counties because that data was not made avaibable in daily increments.
]]
local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )

local function map(value, istart, istop, ostart, ostop)
  return (ostart + (ostop - ostart) * ((value - istart) / (istop - istart)))
end

local function onClick(event)
  local options = {
    effect = "slideDown",
    time = 800,
    params = {
      sot = stateObjTable,
      dat = dateList,
      mc = maxCasesTbl,
      md = maxDeathsTbl
    }
  }
  composer.gotoScene("countryScene", options)
end

local function sliderListener(event)
  if (event.target.id == "date") then
    if (event.value > 98) then
      dS = 98
      dateBox.text = dateList[98]
      if (event.phase == "ended") then
        local message = ""
        for _, p in ipairs(stateObjTable) do
          if (p.name == sel) then
            for i, county in ipairs(p.counties) do
              message = message..string.format ("%-20s%10i", county.name, county.cases[dS]).."\n"
              countyBox.text = message
              vertScale = map(p.casesByDay[dS], 0, p.casesByDay[98], 0, 450)
              casesBar.height = vertScale
              vertScale_2 = map(p.deathsByDay[dS], 0, p.deathsByDay[98], 0, 450 * (p.deathsByDay[98] / p.casesByDay[98]))
              deathsBar.height = vertScale_2
            end
          end
        end
      end
    elseif (event.value == 0) then
      dS = 1
      dateBox.text = dateList[1]
      if (event.phase == "ended") then
        local message = ""
        for _, p in ipairs(stateObjTable) do
          if (p.name == sel) then
            for i, county in ipairs(p.counties) do
              message = message..string.format ("%-20s%10i", county.name, county.cases[dS]).."\n"
              countyBox.text = message
              vertScale = map(p.casesByDay[dS], 0, p.casesByDay[98], 0, 450)
              casesBar.height = vertScale
              vertScale_2 = map(p.deathsByDay[dS], 0, p.deathsByDay[98], 0, 450 * (p.deathsByDay[98] / p.casesByDay[98]))
              deathsBar.height = vertScale_2
            end
          end
        end
      end
    else
      dS = event.value
      dateBox.text = dateList[event.value]
      if ( event.phase == "ended" ) then
        local message = ""
        for _, p in ipairs(stateObjTable) do
          if (p.name == sel) then
            for i, county in ipairs(p.counties) do
              message = message..string.format ("%-20s%10i", county.name, county.cases[dS]).."\n"
              countyBox.text = message
              vertScale = map(p.casesByDay[dS], 0, p.casesByDay[98], 0, 450)
              casesBar.height = vertScale
              vertScale_2 = map(p.deathsByDay[dS], 0, p.deathsByDay[98], 0, 450 * (p.deathsByDay[98] / p.casesByDay[98]))
              deathsBar.height = vertScale_2
            end
          end
        end
      end
    end
  end
end

comparisonString = nil
local function textListener(event)
  local message = ""
  if ( event.phase == "began") then
    --begin editing
  elseif (event.phase == "ended" or event.phase == "submitted") then
    --after editing
  elseif (event.phase == "editing") then
    comparisonString = defaultBox.text
    for _, s in ipairs(stateObjTable) do
      if (s.name == sel) then
        for i, name in ipairs(s.counties) do
          if (((name.name:sub(1, comparisonString:len())):lower()):match(comparisonString:lower())) then
            message = message..string.format ("%-20s%10i", name.name, name.cases[dS]).."\n"
            countyBox.text = message
          end
        end
      end
    end
  end
end

function scene:create(event)
  local sceneGroup = self.view
  local params = event.params
  stateObjTable = params.st
  dateList = params.dl
  date = params.d
  maxCasesTbl = params.mc
  maxDeathsTbl = params.md
  sel = params.n
  print(sel)
  display.setDefault("background", 208/255, 200/255, 189/255)
  dateSlider = widget.newSlider(
    {
        id = "date",
        x = 225,
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
      text = "< Overview",
      fontSize = 50,
      x = stateButton.x + 25,
      y = stateButton.y,
    }
  )
  text:setFillColor(0, 0, 0)
  text.x = stateButton.x
  text.y = stateButton.y
  stateButton.text = text
  sceneGroup:insert(text)
  stateButton:addEventListener("tap", onClick)
  if (date > 98) then
    date = 98
  elseif (date == 0) then
    date = 1
  end
  dateBox = display.newText(
    {
        text = dateList[date],
        fontSize = 50,
        x = dateSlider.x,
        y = dateSlider.y + 500,
    }
  )
  dateBox:setFillColor(0, 0, 0)
  dateLabel = display.newText(
    {
      text = "Date",
      fontSize = 50,
      x = dateSlider.x,
      y = dateSlider.y - 75,
    }
  )
  dateLabel:setFillColor(0, 0, 0)
  sceneGroup:insert(dateLabel)
  countyBox = native.newTextBox( 600, display.contentCenterY + 50, 500, 700 )
  msg = ""
  for _, s in ipairs(stateObjTable) do
    if (s.name == sel) then
      for a, b in ipairs(s.counties) do
        msg = msg..string.format ("%-20s%10i", b.name, b.cases[dS]).."\n"
      end
    end
  end
  countyBox.text = msg
  countyBox.font = native.newFont( "Courier New", 25 )

  defaultBox = native.newTextField(display.contentWidth - 600, display.contentCenterY - 300, 500, 50)
  defaultBox.anchorX = 0;
  defaultBox.isEditable = true
  defaultBox:addEventListener("userInput", textListener)
  defaultBox.isFontSizeScaled = true
  defaultBox.size = 25
  defaultBox.placeholder = "Search"
  local stateTitle = display.newText(
    {
      text = sel,
      fontSize = 100,
      x = display.contentCenterX,
      y = 100
    }
  )
  stateTitle:setFillColor(0, 0, 0)

  local stayAtHome = display.newText(
    {
      text = "Stay at Home:     ",
      fontSize = 50,
      x = stateTitle.x,
      y = stateTitle.y + 70
    }
  )
  stayAtHome:setFillColor(0, 0, 0)

  local stayAtHomeAnswer = display.newText(
    {
      text = "Yes",
      fontSize = 50,
      x = stayAtHome.x + 185,
      y = stayAtHome.y
    }
  )
  stayAtHomeAnswer:setFillColor(1, 0, 0)

  local countyLabel = display.newText(
    {
      text = "Counties",
      fontSize = 50,
      x = countyBox.x,
      y = countyBox.y - 385
    }
  )
  countyLabel:setFillColor(0, 0, 0)

  for _, s in ipairs(stateObjTable) do
    if (s.name == sel) then
      init_C = s.casesByDay[dS]
      init_D = s.deathsByDay[dS]
      high_C = s.casesByDay[98]
      high_D = s.deathsByDay[98]
      break
    end
  end
  scale_C = map(init_C, 0, high_C, 0, 450)
  scale_D = map(init_D, 0, high_D, 0, 450 * (high_D / high_C))
  casesBar = display.newRect(display.contentCenterX - 100, display.contentCenterY + 350, 50, scale_C)
  casesBar:setFillColor(1, 0.5625, 0)
  casesBar.anchorY = 1.0

  deathsBar = display.newRect( display.contentCenterX + 100, display.contentCenterY + 350, 50, scale_D )
  deathsBar:setFillColor(1, 0, 0)
  deathsBar.anchorY = 1.0

  sceneGroup:insert(casesBar)
  sceneGroup:insert(deathsBar)
  sceneGroup:insert(countyLabel)
  sceneGroup:insert(stateTitle)
  sceneGroup:insert(stayAtHome)
  sceneGroup:insert(stayAtHomeAnswer)
  sceneGroup:insert(dateSlider)
  sceneGroup:insert(dateBox)
  sceneGroup:insert(countyBox)
  sceneGroup:insert(defaultBox)
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
