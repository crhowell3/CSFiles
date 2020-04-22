--[[
State class for all state objects
]]

local State = {};

function State:new (obj)
  obj = obj or {};
  setmetatable( obj, self );
  self.__index = self;
  return obj;
end

function State:spawn()

end

function State:touch()

end

function State:display()

end

return State
