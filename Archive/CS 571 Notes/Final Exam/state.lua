--[[
State class for all state objects
]]

local State = {counties = {}, name = "", xPos = 0, yPos = 0, r = 1, g = 1, b = 1, a = 1, isSelected = false, deaths = 0, confirmed = 0, radius = 0, delta = 0};

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
  self.shape.strokeWidth = 5;
end

function State:touch()
  local function onStateTouch (event)
    --for _, k in ipairs(stateObjTable) do
      --k.shape.strokeWidth = 0
      --k.isSelected = false
    --end
    --The above code is for reverting all other selections to their normal state so that only one is selected
    event.target.strokeWidth = 7
    event.target.isSelected = true
  end
  self.shape:addEventListener("tap", onStateTouch);
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
