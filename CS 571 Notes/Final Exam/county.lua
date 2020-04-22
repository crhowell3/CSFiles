local State = require( "state" )
local County = State:new()

local event = {name="deltaAlert"}

function County:new(obj)
  obj = obj or {};
  setmetatable( obj, self );
  self.__index = self;
  return obj;
end

function County:spawn()
  self.shape = display.newCircle(self.xPos, self.yPos, self.radius)
  self.shape.pp = self;
  self.shape:setFillColor(self.r, self.g, self.b);
  self.shape.strokeWidth = 5;
end

function County:touch(g)
  local function onCountyTouch (event)
    event.target.strokeWidth = 10
    event.target.isSelected = true
    toggle = true
    self:display(g)
  end
end

function County:display(g)
  if (toggle == true) then
    local nameText = display.newText(
      {
        text = self.name .. '\nDeaths: ' .. self.deaths .. '\nCases: ' .. self.confirmed,
        fontSize = 50,
        x = display.contentCenterX,
        y = display.contentHeight - 100
      }
    )
    self.title = nameText
    g:insert(self.title);
  else
    display.remove(self.title)
  end
  local function showAlert (event)
    local alert = display.newText(
      {
        text = "!",
        fontSize = 50,
        x = self.x,
        y = self.y
      }
    )
    alert:setTextColor(1, 1, 0)
    self.al = alert
    g:insert(self.al)
  end
  self:addEventListener("deltaAlert", showAlert)
end

return County
