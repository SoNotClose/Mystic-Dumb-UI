-- playa stuff

getgenv().MysticUI = getgenv().MysticUI or loadstring(game:HttpGet("https://raw.githubusercontent.com/SoNotClose/Mystic-Dumb-UI/main/MysticRobloxUi/MysticLib/MysticUI.lua"))()
local MysticUI = getgenv().MysticUI

local pt = MysticUI.PlayerTab
local PlayerSection = pt:CreateSection("Player")

local LPlayerSection = pt:CreateSection("Local Player")
-- ik i made a joke on my discord about this being skidded but its actuall not i goe it from a yt vidio so kinda
local WSSlida = pt:CreateSlider({
   Name = "WalkSpeed",
   Range = {0, 250},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 16,
   Flag = "WalkSpeed",
   Callback = function(Value)
      local player = game.Players.LocalPlayer
      if player and player.Character and player.Character:FindFirstChild("Humanoid") then
         player.Character.Humanoid.WalkSpeed = Value
      end
   end,
})

local JPSlida = pt:CreateSlider({
   Name = "JumpPower",
   Range = {0, 250},
   Increment = 5,
   Suffix = "Power",
   CurrentValue = 30,
   Flag = "JumpPower",
   Callback = function(Value)
      local player = game.Players.LocalPlayer
      if player and player.Character and player.Character:FindFirstChild("Humanoid") then
         player.Character.Humanoid.JumpPower = Value
      end
   end,
})

local SizeSlider = pt:CreateSlider({
   Name = "Player Size",
   Range = {0.1, 5.0}, -- You can go higher, but physics may get weird : nexus
   Increment = 0.1,
   Suffix = "x",
   CurrentValue = 1.0,
   Flag = "charsize",
   Callback = function(Value)
      local player = Players.LocalPlayer
      local character = player.Character
      if not character then return end

      for _, part in ipairs(character:GetDescendants()) do
         if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
            part.Size = Vector3.new(1,1,1) * Value
         elseif part:IsA("SpecialMesh") then
            part.Scale = Vector3.new(1,1,1) * Value
         end
      end

      local root = character:FindFirstChild("HumanoidRootPart")
      if root then
         root.Size = Vector3.new(2,2,1) * Value
      end

      local humanoid = character:FindFirstChildOfClass("Humanoid")
      if humanoid then
         humanoid.HipHeight = Value * 2
      end
   end,
})

local jumpConnection

local InfJump = pt:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfiniteJump",
   Callback = function(enabled)
      local UIS = game:GetService("UserInputService")
      local Players = game:GetService("Players")
      local LocalPlayer = Players.LocalPlayer
         
      if enabled then -- ik theres multipel ways of doing this but i wanna try this
         jumpConnection = UIS.JumpRequest:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
               LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
         end)
      else
         if jumpConnection then
            jumpConnection:Disconnect()
            jumpConnection = nil
         end
      end
   end,
})


local LPlayerSection = pt:CreateSection("Global Players")

local selectedPlayer = nil
local tweenSpeed = 2
local tpMode = "Teleport"

local PlayerDropdown = pt:CreateDropdown({
   Name = "Select Player",
   Options = {},
   CurrentOption = {},
   MultipleOptions = false,
   Flag = "plrlistdropdown",
   Callback = function(Options)
      selectedPlayer = Options[1]
   end,
})

local function updatePlayerList()
   local names = {}
   for _, player in ipairs(game.Players:GetPlayers()) do
      table.insert(names, player.Name)
   end
   PlayerDropdown:Refresh(names)
end

updatePlayerList()
game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)



local ForceUpdatePlrList = pt:CreateButton({
   Name = "Force Update List",
   Callback = function()
      updatePlayerList()
   end,
})


local TPMode = pt:CreateDropdown({
   Name = "TP Mode",
   Options = {"Tween", "Teleport", "CFrame"},
   CurrentOption = {"Teleport"},
   MultipleOptions = false,
   Flag = "tpmode",
   Callback = function(Options)
      tpMode = Options[1]
   end,
})

local tweenSpeed = 2

local TweenSpeed = pt:CreateSlider({
   Name = "Tween Speed",
   Range = {1, 10},
   Increment = 0.5,
   Suffix = "s",
   CurrentValue = 2,
   Flag = "tweenspeedslider",
   Callback = function(Value)
      tweenSpeed = Value
   end,
})

local Teleport = pt:CreateButton({
   Name = "Teleport to Player",
   Callback = function()
      local localPlayer = game.Players.LocalPlayer
      local targetPlayer = game.Players:FindFirstChild(selectedPlayer)

      if not (localPlayer and targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")) then
         print("Teleport failed invalid target.")
         return
      end

      local targetPos = targetPlayer.Character.HumanoidRootPart.Position
      local hrp = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")

      if not hrp then return end

      if tpMode == "Teleport" then
         hrp.Position = targetPos
      elseif tpMode == "CFrame" then
         local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
         local targetCFrame = targetHRP and targetHRP.CFrame
      if targetCFrame then
         hrp.CFrame = CFrame.new(targetCFrame.Position) * CFrame.Angles(0, targetCFrame:ToEulerAnglesYXZ())
      end
      elseif tpMode == "Tween" then
         local TweenService = game:GetService("TweenService")
         local tweenInfo = TweenInfo.new(tweenSpeed, Enum.EasingStyle.Linear)
         local goal = {CFrame = CFrame.new(targetPos)}
         local tween = TweenService:Create(hrp, tweenInfo, goal)
         tween:Play()
      end
   end,
})







