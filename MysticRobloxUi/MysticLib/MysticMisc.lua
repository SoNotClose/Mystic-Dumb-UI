-- ill post stupid things here

---@diagnostic disable: undefined-global
local MysticUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/SoNotClose/Mystic-Dumb-UI/main/MysticRobloxUi/MysticLib/MysticUI.lua"))()
local misc = MysticUI.MiscTab
local MiscSection = misc:CreateSection("Misc")

local UnloadButton = MysticUI.MiscTab:CreateButton({
   Name = "Unload",
   Callback = function()
      Rayfield:Destroy()
   end,

})

