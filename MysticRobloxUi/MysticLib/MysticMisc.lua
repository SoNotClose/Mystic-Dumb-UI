-- ill post stupid things here

getgenv().MysticUI = getgenv().MysticUI or loadstring(game:HttpGet("https://raw.githubusercontent.com/SoNotClose/Mystic-Dumb-UI/main/MysticRobloxUi/MysticLib/MysticUI.lua"))()
local MysticUI = getgenv().MysticUI
local misc = MysticUI.MiscTab
-- local MiscSection = misc:CreateSection("Misc")

local Rejoin = MysticUI.MiscTab:CreateButton({
   Name = "Rejoin",
   Callback = function()
      local TS = game:GetService("TeleportService")
      local Plrs = game:GetService("Players")
      local pId = game.PlaceId
      local jId = game.JobId
      TS:TeleportToPlaceInstance(pId, jId, Plrs.LocalPlayer)
   end,
})


})




