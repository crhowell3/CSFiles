--[[
State class for all State instances
]]
local composer = require( "composer" )
local State = {name = "", counties = {}, casesByDay = {}, deathsByDay = {}, xPos = 0, yPos = 0, r = 0, g = 0, b = 0, isSelected = false}

--NOTE: THESE ARE NOT FINAL
function State:new (obj)
  obj = obj or {};
  setmetatable( obj, self );
  self.__index = self;
  return obj;
end

function State:spawn()
  self.shape = display.newRect(self.xPos, self.yPos, 100, 100)
  self.shape.pp = self;
  self.shape:setFillColor(self.r, self.g, self.b);
  self.shape.strokeWidth = 0;
end

function State:touch(g, tbl, list)
  local function onStateTouch (event)
    if (event.numTaps == 1) then
      for _, k in ipairs(tbl) do
        k.shape.strokeWidth = 0
        k.isSelected = false
        toggle = false
        k:display()
      end
      event.target.strokeWidth = 10
      event.target.isSelected = true
      toggle = true
      selectedState = self
      self:display(g)
    elseif (event.numTaps == 2) then
      local options = {
        effect = "fade",
        time = 800,
        params = {
          st = tbl,
          dl = list
        }
      }
      if (selectedState ~= nil) then
        composer.gotoScene("stateScene", options)
      end
    end
  end
  self.shape:addEventListener("tap", onStateTouch);
end

function State:display(g)
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

return State
