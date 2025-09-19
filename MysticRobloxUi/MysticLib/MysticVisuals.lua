-- idk how to make esp or anything lolololol

getgenv().MysticUI = getgenv().MysticUI or loadstring(game:HttpGet("https://raw.githubusercontent.com/SoNotClose/Mystic-Dumb-UI/main/MysticRobloxUi/MysticLib/MysticUI.lua"))()
local MysticUI = getgenv().MysticUI
local visual = MysticUI.VisualTab
local vSection = visual:CreateSection("Visuals")

-- my attempt at making esp / cahms or whatever u call it
local ChamsEnabled = false

local highlights = {}

local ChamsToggle = visual:CreateToggle({
    Name = "Chams",
    CurrentValue = false,
    Flag = "ChamsToggle",
    Callback = function(enabled)
        ChamsEnabled = enabled

        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")

        if enabled then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= Players.LocalPlayer and player.Character then
                    local highlight = Instance.new("Highlight")
                    highlight.Adornee = player.Character
                    highlight.FillTransparency = 1
                    highlight.OutlineTransparency = 0
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Parent = player.Character
                    highlights[player] = highlight
                end
            end

            Players.PlayerAdded:Connect(function(p)
                p.CharacterAdded:Connect(function(char)
                    if ChamsEnabled then
                        local highlight = Instance.new("Highlight")
                        highlight.Adornee = char
                        highlight.FillTransparency = 1
                        highlight.OutlineTransparency = 0
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.Parent = char
                        highlights[p] = highlight
                    end
                end)
            end)
        else
            for player, highlight in pairs(highlights) do
                if highlight and highlight.Parent then
                    highlight:Destroy()
                end
            end
            highlights = {}
        end
    end,
})

-- Color Picker
local ChamsClr = visual:CreateColorPicker({
    Name = "Chams Color",
    Color = Color3.fromRGB(255, 255, 255),
    Flag = "chamscolro",
    Callback = function(Value)
        local Players = game:GetService("Players")

        for player, highlight in pairs(highlights) do
            if highlight and highlight.Parent then
                highlight.OutlineColor = Value
            end
        end
    end,
})

