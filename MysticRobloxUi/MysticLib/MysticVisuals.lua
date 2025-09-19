-- idk how to make esp or anything lolololol

getgenv().MysticUI = getgenv().MysticUI or loadstring(game:HttpGet("https://raw.githubusercontent.com/SoNotClose/Mystic-Dumb-UI/main/MysticRobloxUi/MysticLib/MysticUI.lua"))()
local MysticUI = getgenv().MysticUI
local visual = MysticUI.VisualTab
local vSection = visual:CreateSection("Visuals")

-- my attempt at making esp / cahms or whatever u call it
local Players = game:GetService("Players") -- the one tiem u will catch me declaring serbices ourside of  the code

local LocalPlayer = Players.LocalPlayer

local ChamsEnabled = false
local highlights = {}

local ignoreTeam = false

local visibleColor = Color3.fromRGB(255, 255, 255)

local teamColor = Color3.fromRGB(0, 255, 0)

local Chams = visual:CreateToggle({
    Name = "Chams",
    CurrentValue = false,
    Flag = "chams",
    Callback = function(enabled)
        ChamsEnabled = enabled

        if enabled then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    if ignoreTeam and player.Team == LocalPlayer.Team then continue end

                    local highlight = Instance.new("Highlight")
                    highlight.Adornee = player.Character
                    highlight.FillTransparency = 1
                    highlight.OutlineTransparency = 0
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.OutlineColor = (player.Team == LocalPlayer.Team) and teamColor or visibleColor
                    highlight.Parent = player.Character
                    highlights[player] = highlight
                end
            end

            Players.PlayerAdded:Connect(function(p)
                p.CharacterAdded:Connect(function(char)
                    if ChamsEnabled and (not ignoreTeam or p.Team ~= LocalPlayer.Team) then
                        local highlight = Instance.new("Highlight")
                        highlight.Adornee = char
                        highlight.FillTransparency = 1
                        highlight.OutlineTransparency = 0
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.OutlineColor = (p.Team == LocalPlayer.Team) and teamColor or visibleColor
                        highlight.Parent = char
                        highlights[p] = highlight
                    end
                end)
            end)
        else
            for _, h in pairs(highlights) do
                if h and h.Parent then h:Destroy() end
            end
            highlights = {}
        end
    end,
})

local IgnoreTeam = visual:CreateToggle({
    Name = "Ignore Team",
    CurrentValue = false,
    Flag = "ignoreteam",
    Callback = function(value)
        ignoreTeam = value
    end,
})

local VisibleClr = visual:CreateColorPicker({
    Name = "Visible Color",
    Color = Color3.fromRGB(255, 255, 255),
    Flag = "visablecolr",
    Callback = function(value)
        visibleColor = value
        for player, highlight in pairs(highlights) do
            if player.Team ~= LocalPlayer.Team then
                highlight.OutlineColor = visibleColor
            end
        end
    end,
})

local TeamClr = visual:CreateColorPicker({
    Name = "Team Color",
    Color = Color3.fromRGB(0, 255, 0),
    Flag = "teamclr",
    Callback = function(value)
        teamColor = value
        for player, highlight in pairs(highlights) do
            if player.Team == LocalPlayer.Team then
                highlight.OutlineColor = teamColor
            end
        end
    end,
})


