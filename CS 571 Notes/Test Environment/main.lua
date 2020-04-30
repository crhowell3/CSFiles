local physics = require("physics")
display.setStatusBar(display.HiddenStatusBar)

-- create a circle and put it in the center of the screen
local circle = display.newCircle( display.contentWidth*0.5,display.contentHeight*0.5, 75)
circle:setFillColor( 255 )

-- touch listener function
function circle:touch( event )
  if event.phase == "began" then
    display.getCurrentStage():setFocus( self, event.id )
    self.isFocus = true
    self.markX = self.x
    self.markY = self.y
  elseif self.isFocus then
    if event.phase == "moved" then
      self.x = event.x - event.xStart + self.markX
      self.y = event.y - event.yStart + self.markY
    elseif event.phase == "ended" or event.phase == "cancelled" then
      physics.start()
      physics.addBody( circle, "dynamic" )
      display.getCurrentStage():setFocus( self, nil )
      self.isFocus = false
    end
  end
  return true
end
-- finally, add an event listener to our circle to allow it to be dragged
circle:addEventListener( "touch", circle )
