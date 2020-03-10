# CS 571 Notes | 10 March 2020
## Lua OOP Part III
### squareObject.lua
``` lua
local movingObject = require ("movingObject");

local squareObject = movingObject:new();

--etc.
```

### debuggable.lua
``` lua
local debuggable = {};

function debuggable:touch(event)
  self.s:setLinearVelocity(0,0);
  self.s.isFixedRotation = true
  print("Debug me please: ", self);
end

return debuggable;
```

### specialObject.lua - search()
``` lua
local function search (k, plist)
  for i = 1, #plist do
    local v = plist[i][k];
    if v then return v end
  end
end
```

## Collision Filter
### Collision Filtering
- Collision Filter: selectively choose which objects collide with each other

### Collision Filter Worksheet
- See slide
