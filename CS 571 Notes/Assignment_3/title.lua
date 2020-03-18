local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()

local function onClick(event)
  if ("ended" == event.phase) then
    local options = {
      effect = "fade",
      time = 800
    }
    composer.gotoScene("game", options)
  end
end

function scene:create(event)
  local sceneGroup = self.view
  local green = {101/255, 204/255, 184/255}
  local eggshell = {242/255, 242/255, 242/255}
  display.setDefault( "background", unpack(green) )

  local button1 = widget.newButton(
    {
      x = display.contentWidth / 2,
      y = display.contentHeight / 2 + 300,
      id = "continue",
      label = "Start",
      onEvent = onClick,
      font = "fonts/Montserrat-Medium",
      fontSize = 75,
      labelColor = { default=eggshell, over={0, 0, 0, 0.5}}
    }
  )

  local title = display.newText(
    {
      text = "The Brain Train",
      x = display.contentWidth / 2,
      y = display.contentHeight / 2 - 50,
      font = "fonts/PlayfairDisplayBoldItalic",
      fontSize = 125
    }
  )
  title:setFillColor( unpack(eggshell))

  local line = display.newRect( title.x, title.y + 100, display.contentWidth / 1.375, 10 )
  line:setFillColor(unpack(eggshell))

  local subtitle = display.newText(
    {
      text = "Developed by Cameron Howell",
      x = title.x,
      y = title.y + 150,
      font = "fonts/PlayfairDisplayBoldItalic",
      fontSize = 50
    }
  )
  subtitle:setFillColor(unpack( eggshell ))

  sceneGroup:insert(title)
  sceneGroup:insert(subtitle)
  sceneGroup:insert(line)
  sceneGroup:insert(button1)
end

function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase
  if ( phase == "will" ) then
  elseif ( phase == "did" ) then
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
