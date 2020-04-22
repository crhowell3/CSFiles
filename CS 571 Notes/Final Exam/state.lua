--[[
State class for all state objects
]]

local State = {counties = {}, name = "", xPos = 0, yPos = 0, r = 1, g = 1, b = 1};

function State:new (obj)
  obj = obj or {};
  setmetatable( obj, self );
  self.__index = self;
  return obj;
end

function State:spawn()
  self.shape = display.newSquare(self.xPos, self.yPos, 100, 100)
  self.shape.pp = self;
  self.shape:setFillColor(self.r, self.g, self.b);
end

function State:touch()
  local function onStateTouch (event)
    event.target.strokeWidth = 5;
  end
  self:addEventListener("tap", onStateTouch);
end

function State:display()
  local nameText = display.newText(
    {
      text = self.name,
      fontSize = 125,
      x = display.contentCenterX,
      y = display.contentHeight - 100
    }
  )
end

return State
