--[[
This scene contains the title, subtitle, and button to progress to the next scene.
This scene passes some initial values for certain variables in the game scene because
the game scene's variables are constantly being wiped out due to changing and reloading
the scene.
]]
local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()

--The onClick event handler initializes the transition to the game scene whenever the
--user taps on the button
local function onClick(event)
  if ("ended" == event.phase) then
    local options = {
      effect = "fade",
      time = 800,
      params = {
        c = 3,
        r = 1,
        s = 0,
        a = 0
      }
    }
    composer.removeScene("title")
    composer.gotoScene("game", options)
  end
end

--The tables with the numbers below are simply the RGB values for objects in the
--scene view. All the objects, i.e., the button, title, etc., are declared here
--so that they can be added to the sceneview. This is important because all items
--in the sceneview are deleted once this scene transitions to the next
function scene:create(event)
  local sceneGroup = self.view
  local green = {101/255, 204/255, 184/255}
  local eggshell = {242/255, 242/255, 242/255}
  local pine = {87/255, 186/255, 152/255}
  display.setDefault( "background", unpack(green) )

--Initialization for the button widget
  local button1 = widget.newButton(
    {
      x = display.contentWidth / 2,
      y = display.contentHeight / 2 + 300,
      id = "continue",
      label = "Start",
      onEvent = onClick,
      font = "fonts/Montserrat-Medium",
      fontSize = 75,
      labelColor = { default=eggshell, over=pine}
    }
  )

--Definition for the title
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

--This line object is just for a little flair and decoration
  local line = display.newRect( title.x, title.y + 100, display.contentWidth / 1.375, 10 )
  line:setFillColor(unpack(eggshell))

--Definition for the subtitle
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

--All display objects are added to the sceneGroup so that they can be cleared whenever
--the scene transitions
  sceneGroup:insert(title)
  sceneGroup:insert(subtitle)
  sceneGroup:insert(line)
  sceneGroup:insert(button1)
end

--Nothing happens here, but this function is still necessary for displaying what
--was previously created
function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase
  if ( phase == "will" ) then
  elseif ( phase == "did" ) then
  end
end

--Hides all sceneGroup objects before deleting
function scene:hide(event)
  local sceneGroup = self.view
  local phase = event.phase
  if ( phase == "will" ) then
  elseif ( phase == "did" ) then
  end
end

--Destroys all objects in the sceneGroup so that they won't interfere with the
--next scene
function scene:destroy(event)
  local sceneGroup = self.view
end

--Necessary eventListeners so that the scene can perform these functions
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
