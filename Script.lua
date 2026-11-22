local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local SOUND_ID = "rbxassetid://78563877745959"

local function replaceSound(sound)
    if not sound:IsA("Sound") or sound.Name ~= "GunKill" then return end

    sound.SoundId = SOUND_ID
    sound.Volume = 5

    if sound:GetAttribute("Monitor") then return end
    sound:SetAttribute("Monitor", true)

    sound:GetPropertyChangedSignal("SoundId"):Connect(function()
        if sound.SoundId ~= SOUND_ID then
            sound.SoundId = SOUND_ID
        end
    end)
end

local function scan(container)
    for _, object in ipairs(container:GetDescendants()) do
        replaceSound(object)
    end

    container.DescendantAdded:Connect(replaceSound)
end

scan(Workspace)

if LocalPlayer.Character then
    scan(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(scan)

task.spawn(function()
    while true do
        scan(Workspace)

        if LocalPlayer.Character then
            for _, object in ipairs(LocalPlayer.Character:GetDescendants()) do
                replaceSound(object)
            end
        end

        task.wait(0.1)
    end
end)