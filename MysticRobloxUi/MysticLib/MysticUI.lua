-- just wanna say thanks to sirius or whoever made rayfield this little proeject would not have been possible without it
-- im mainly making this so i can dilly dally with lua
-- all open sourced

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local version = "1.0.2"

local MysticUI = {}

MysticUI.Window = Rayfield:CreateWindow({
   Name = "Mystic Hub " .. version,
   Icon = 0,
   LoadingTitle = "Universal Dumb Hub",
   LoadingSubtitle = "by sonotclose",
   ShowText = "",
   Theme = "Default",
   ToggleUIKeybind = Enum.KeyCode.Insert,
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "mysticconfig"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvitelink",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {""}
   }
})

-- all tabs here
MysticUI.MainTab = MysticUI.Window:CreateTab("Main", "crown")
MysticUI.PlayerTab = MysticUI.Window:CreateTab("Player", "user-round")
MysticUI.FunTab = MysticUI.Window:CreateTab("Fun", "party-popper")
MysticUI.VisualTab = MysticUI.Window:CreateTab("Visuals", "scan-eye")
MysticUI.ExTab = MysticUI.Window:CreateTab("Experimental", "wrench")
MysticUI.MiscTab = MysticUI.Window:CreateTab("Misc", "bolt")
MysticUI.UITab = MysticUI.Window:CreateTab("UI", "file")

local UISection = MysticUI.UITab:CreateSection("UI")
local Unload = MysticUI.UITab:CreateButton({
   Name = "Unload",
   Callback = function()
      Rayfield:Destroy()
   end,
})

local SaveConfig = MysticUI.UITab:CreateButton({
   Name = "Save Config",
   Callback = function()
      Rayfield:SaveConfiguration()
   end,
})

local LoadConfig = MysticUI.UITab:CreateButton({
   Name = "Load Config",
   Callback = function()
      Rayfield:LoadConfiguration()
   end,
})

--for exec paste all tabs under here

-- leave 

-- loadconfig
-- Rayfield:LoadConfiguration()
return MysticUI




