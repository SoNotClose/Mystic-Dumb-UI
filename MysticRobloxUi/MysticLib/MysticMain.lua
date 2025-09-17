-- ill post stupid things here

getgenv().MysticUI = getgenv().MysticUI or loadstring(game:HttpGet("https://raw.githubusercontent.com/SoNotClose/Mystic-Dumb-UI/main/MysticRobloxUi/MysticLib/MysticUI.lua"))()
local MysticUI = getgenv().MysticUI

local versiongot = MysticUI.version

local log = "The release of mystic hub"

local changelog = {
   "Added Main Tab",
   "Added Player Tab",
   "Added Fun Tab",
   "Added Experimental Tab",
   "Added Visual Tab",
   "Added Misc Tab",
   "Added Walkspeed (slider)",
   "Added JumpPower (slider)",
   "Added Teleport To Player (dropdown)",
   "Added Teleport Mode (dropdown)",
   "alot more"
}

local newchangelog = log .. "\n\n"

for _, e in ipairs(changelog) do
   newchangelog = newchangelog .. "- " .. e .. "\n"
end

-- local Changelog = MysticUI.MainTab:CreateLabel(newchangelog, "megaphone", Color3.fromRGB(120, 120, 120), false)




