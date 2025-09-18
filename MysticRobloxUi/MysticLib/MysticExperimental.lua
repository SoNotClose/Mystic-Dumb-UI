-- ill post expermental things here

getgenv().MysticUI = getgenv().MysticUI or loadstring(game:HttpGet("https://raw.githubusercontent.com/SoNotClose/Mystic-Dumb-UI/main/MysticRobloxUi/MysticLib/MysticUI.lua"))()
local MysticUI = getgenv().MysticUI
local ex = MysticUI.ExTab
local ExSection = ex:CreateSection("Experimental")

local PrintCords = ex:CreateButton({
   Name = "Print Cords",
   Callback = function()
      local player = game.Players.LocalPlayer
      if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
         local pos = player.Character.HumanoidRootPart.Position
         local coords = string.format("X: %.2f, Y: %.2f, Z: %.2f", pos.X, pos.Y, pos.Z)

         print("Your cords are ", coords)

         game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Current Cordinates",
            Text = coords,
            Duration = 2
         })
      else
         print("Unable to retrieve cordinates.")
         game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Error",
            Text = "Could not find your character",
            Duration = 2
         })
      end
   end,
})

local ExChatSection = ex:CreateSection("Chat Spamming")

local chatMode = "All"

local message = ""

local mps = 1

local spamming = false

local spamThread = nil

local SpamChat = ex:CreateInput({
   Name = "Spam Message",
   CurrentValue = "",
   PlaceholderText = "Type your message...",
   RemoveTextAfterFocusLost = false,
   Flag = "spamchat",
   Callback = function(Text)
      message = Text
   end,
})

local ChatMode = ex:CreateDropdown({
   Name = "Chat Mode",
   Options = {"All", "Team", "Self"},
   CurrentOption = {"All"},
   MultipleOptions = false,
   Flag = "chatmode",
   Callback = function(Options)
      chatMode = Options[1]
   end,
})

local SpamSpeed = ex:CreateSlider({
   Name = "Spam Speed",
   Range = {1, 65},
   Increment = 1,
   Suffix = "MPS",
   CurrentValue = 1,
   Flag = "spamspeed",
   Callback = function(Value)
      mps = Value
   end,
})

local AntiDelay = ex:CreateToggle({
   Name = "Anti Chat Delay (slows mps)",
   CurrentValue = false,
   Flag = "antidelay",
   Callback = function(Value)
      mps = 15.5327 -- accoring to my stopwatch [PATCHED] litterly in seconsd
   end,
})

local TestMessage = ex:CreateButton({
   Name = "Test Message",
   Callback = function()
      local msg = message
      -- not mine
      local textChatService = game:GetService("TextChatService")
      local useTextChat = textChatService:FindFirstChild("TextChannels") ~= nil
      local generalChannel = useTextChat and textChatService.TextChannels:FindFirstChild("RBXGeneral") or nil
      local teamChannel = useTextChat and textChatService.TextChannels:FindFirstChild("RBXTeam") or nil
      local legacyChat = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")

      if chatMode == "Self" then
         game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = msg,
            Color = Color3.fromRGB(255, 255, 255),
            Font = Enum.Font.SourceSansBold,
            FontSize = Enum.FontSize.Size24
         })
      elseif useTextChat then
         if chatMode == "Team" and teamChannel then
            teamChannel:SendAsync(msg)
         elseif generalChannel then
            generalChannel:SendAsync(msg)
         end
      elseif legacyChat then
         legacyChat.SayMessageRequest:FireServer(msg, chatMode)
      else
         print("no chat found")
      end
   end,
})


local SpamMessage = ex:CreateToggle({
   Name = "Spam",
   CurrentValue = false,
   Flag = "spammessagetoggle",
   Callback = function(Value)
      spamming = Value

      if spamming then
         spamThread = task.spawn(function()
            while spamming do
               if message ~= "" then

                  local textChatService = game:GetService("TextChatService")
                  local useTextChat = textChatService:FindFirstChild("TextChannels") ~= nil
                  local generalChannel = useTextChat and textChatService.TextChannels:FindFirstChild("RBXGeneral") or nil
                  local teamChannel = useTextChat and textChatService.TextChannels:FindFirstChild("RBXTeam") or nil
                  local legacyChat = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents")

                  if chatMode == "Self" then
                     game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                        Text = message,
                        Color = Color3.fromRGB(255, 255, 255),
                        Font = Enum.Font.SourceSansBold,
                        FontSize = Enum.FontSize.Size24
                     })
                  elseif useTextChat then
                     if chatMode == "Team" and teamChannel then
                        teamChannel:SendAsync(message)
                     elseif generalChannel then
                        generalChannel:SendAsync(message)
                     end
                  elseif legacyChat then
                     legacyChat.SayMessageRequest:FireServer(message, chatMode)
                  else
                     print("no chat found")
                  end
               end
               task.wait(1 / mps)
            end
         end)
      else
         spamming = false
         if spamThread then
            task.cancel(spamThread)
            spamThread = nil
         end
      end
   end,

})


