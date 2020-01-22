--[[
  make a config.lua file so that the app can be dynamically changed at runtime
  config.lua can change the resolution, scale, and fps
  dynamic image selection to swap in higher resolutions of an image on higher res devices
  Image suffix example: myImage@2x.png, where the suffix is "@2x"
  Must use display.newImageRect instead of display.newImage()
]]

--[[
config.lua example:

application =
{
  content =
  {
    width =  1080
    height = 720
    fps = 30
  }
}
]]

--[[
Register events:
Runtime events - triggered by the system
Touch events - triggered by the user
]]

local box = display.newRect (200, 300, 100, 100);
