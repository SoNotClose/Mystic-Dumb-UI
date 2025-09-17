-- ill post stupid things here

getgenv().MysticUI = getgenv().MysticUI or loadstring(game:HttpGet("https://raw.githubusercontent.com/SoNotClose/Mystic-Dumb-UI/main/MysticRobloxUi/MysticLib/MysticUI.lua"))()
local MysticUI = getgenv().MysticUI

local versiongot = MysticUI.version

local log = "The release of Mystic Hub"

local changelog = {
   "FIXED THE UI FINALLY",
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
   "Fixed CFrame TP"
}

local changelogText = log .. "\n\n"
for _, entry in ipairs(changelog) do
   changelogText = changelogText .. "- " .. entry .. "\n"
end

local changelogP = MysticUI.MainTab:CreateParagraph({
   Title = "Changelog " .. versiongot,
   Content = changelogText
})







