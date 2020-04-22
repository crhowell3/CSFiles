local State = require( "state" )
local County = State:new()

function County:new(obj)
  obj = obj or {};
  setmetatable( obj, self );
  self.__index = self;
  return obj;
end

function County:spawn()
  self.shape = display.newCircle(self.xPos, self.yPos, 15)
  self.shape.pp = self;
  self.shape:setFillColor(self.r, self.g, self.b);
end

function County:touch()
  local function onCountyTouch (event)
    event.target.strokeWidth = 7
    event.target.isSelected = true
  end
  self.shape:addEventListener("tap", onCountyTouch);
end

function County:display()
  local nameText = display.newText(
    {
      text = self.name + '\n' + self.deaths + '\n' + self.confirmed,
      fontSize = 75,
      x = display.contentCenterX,
      y = display.contentHeight - 100
    }
  )
end

return County
