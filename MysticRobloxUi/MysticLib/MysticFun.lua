-- ill post stupid things here

getgenv().MysticUI = getgenv().MysticUI or loadstring(game:HttpGet("https://raw.githubusercontent.com/SoNotClose/Mystic-Dumb-UI/main/MysticRobloxUi/MysticLib/MysticUI.lua"))()
local MysticUI = getgenv().MysticUI
local fun = MysticUI.FunTab
local FunSection = fun:CreateSection("Fun")

local spinning = false

local spinSpeed = 5 -- should be dgr per frame

local spinThread = nil

local SpinBot = fun:CreateToggle({
   Name = "Spin Bot",
   CurrentValue = false,
   Flag = "spinbot",
   Callback = function(Value)
      spinning = Value

      if spinning then
         spinThread = task.spawn(function()
            while spinning do
               local player = game.Players.LocalPlayer
               if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                  local hrp = player.Character.HumanoidRootPart
                  hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
               end
               task.wait()
            end
         end)
      else
         if spinThread then
            task.cancel(spinThread)
            spinThread = nil
         end
      end
   end,
})

local SpinBotSpeed = fun:CreateSlider({
   Name = "Spin Speed",
   Range = {1, 150},
   Increment = 1,
   Suffix = "°/frame",
   CurrentValue = 5,
   Flag = "spinbotspeed",
   Callback = function(Value)
      spinSpeed = Value
   end,
})

local flingTarget = nil

local FlingDropdown = fun:CreateDropdown({
   Name = "Fling Player",
   Options = {},
   CurrentOption = {},
   MultipleOptions = false,
   Flag = "flinglist",
   Callback = function(Options)
      flingTarget = Options[1]
   end,
})

local function updateFlingList()
   local names = {}
   for _, player in ipairs(game.Players:GetPlayers()) do
      if player ~= game.Players.LocalPlayer then
         table.insert(names, player.Name)
      end
   end
   FlingDropdown:Refresh(names)
end

updateFlingList() -- same old same old
game.Players.PlayerAdded:Connect(updateFlingList)
game.Players.PlayerRemoving:Connect(updateFlingList)

local ForceUpdateFlngList = fun:CreateButton({
   Name = "Force Update List",
   Callback = function()
      updateFlingList()
   end,
})

local flingPower = 10

local FlngPower = fun:CreateSlider({
   Name = "Fling Power",
   Range = {1, 25},
   Increment = 1,
   Suffix = "Pwr",
   CurrentValue = 10,
   Flag = "flingpower",
   Callback = function(Value)
      flingPower = Value
   end,
})

local flingActive = false

local flingThread = nil

local Fling = fun:CreateToggle({
   Name = "Fling",
   CurrentValue = false,
   Flag = "fling",
   Callback = function(Value)
      flingActive = Value

      if flingActive then
         flingThread = task.spawn(function()
            local localPlayer = game.Players.LocalPlayer
            local targetPlayer = game.Players:FindFirstChild(flingTarget)

            if not (localPlayer and targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart")) then
               print("Fling failed invalid target.") -- cant do warn bc my vsc version
               return
            end

            local hrp = localPlayer.Character:FindFirstChild("HumanoidRootPart")
            local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")

            if not hrp or not targetHRP then return end

            while flingActive do
               hrp.CFrame = targetHRP.CFrame

               hrp.CFrame = hrp.CFrame * CFrame.Angles(
                  math.rad(flingPower * 10),
                  math.rad(flingPower * 10),
                  math.rad(flingPower * 10)
               )

               task.wait()
            end
         end)
      else
         if flingThread then
            task.cancel(flingThread)
            flingThread = nil
         end
      end
   end,
})

local ClickTP = fun:CreateToggle({
    Name = "Click TP",
    CurrentValue = false,
    Flag = "clicktp",
    Callback = function(Value)
        local Players = game:GetService("Players")
        local UserInputService = game:GetService("UserInputService")

        local player = Players.LocalPlayer
        local mouse = player:GetMouse()
        local clickTPEnabled = Value

        mouse.Button1Down:Connect(function()
            if clickTPEnabled then
                local character = player.Character or player.CharacterAdded:Wait()
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart and mouse.Hit then
                    rootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
                end
            end
        end)
    end,
})



local savedCFrame = nil

local SavePos = fun:CreateButton({
    Name = "Save Position",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            savedCFrame = rootPart.CFrame
        end
    end,
})

local TweenService = game:GetService("TweenService")
local tsped = nil

local LoadType = Tab:CreateDropdown({
    Name = "Load Type",
    Options = {"Tween", "CFrame"},
    CurrentOption = {"Tween"},
    MultipleOptions = false,
    Flag = "loadtype",
    Callback = function(Options)
        local method = Options[1]
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local rootPart = character:FindFirstChild("HumanoidRootPart")

        if savedCFrame and rootPart then
            if method == "Tween" then
                local speed = tsped or 10
                local tweenInfo = TweenInfo.new(speed / 10, Enum.EasingStyle.Linear)
                local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = savedCFrame})
                tween:Play()
            elseif method == "CFrame" then
                rootPart.CFrame = savedCFrame
            end
        end
    end,
})

local TweenSpeedSlida = fun:CreateSlider({
    Name = "Tween Speed",
    Range = {0.1, 10},
    Increment = 0.1,
    Suffix = "Speed",
    CurrentValue = 10,
    Flag = "tweenspeedslia",
    Callback = function(Value)
         tsped = value
    end,
})





