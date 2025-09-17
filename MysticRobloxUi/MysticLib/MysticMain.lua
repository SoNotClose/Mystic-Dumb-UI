-- ill post stupid things here

getgenv().MysticUI = getgenv().MysticUI or loadstring(game:HttpGet("https://raw.githubusercontent.com/SoNotClose/Mystic-Dumb-UI/main/MysticRobloxUi/MysticLib/MysticUI.lua"))()
local MysticUI = getgenv().MysticUI

local versiongot = MysticUI.version

local log = "The release of mystic hub"

local changelog = {
   "FIXED THE UI FINNALY",
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
   "Fixed CFRame TP",
   "yes theres bugs with reg tp ik",
}

local newchangelog = log .. "\n\n"

for _, e in ipairs(changelog) do
   newchangelog = newchangelog .. "- " .. e .. "\n"
end

local cchangelog = MysticUI.MainTab:CreateParagraph({Title = "ChangeLog " .. versiongot, Content = newchangelog})






