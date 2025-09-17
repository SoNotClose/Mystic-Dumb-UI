-- ill post stupid things here

---@diagnostic disable: undefined-global
local MysticUI = require("MysticUI")
local misc = MysticUI.MiscTab -- iamgine if i did "fn" 
local MiscSection = misc:CreateSection("Misc")

local UnloadButton = MysticUI.MiscTab:CreateButton({
   Name = "Unload",
   Callback = function()
      Rayfield:Destroy()
   end,
})