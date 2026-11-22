local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local NEW_SOUND_ID = "rbxassetid://78563877745959"

local function replaceSound(sound)
    if sound:IsA("Sound") and sound.Name == "GunKill" then
        if sound.SoundId ~= NEW_SOUND_ID then
            sound.SoundId = NEW_SOUND_ID
        end
    end
end

local function scanCharacter(character)
    for _, object in ipairs(character:GetDescendants()) do
        replaceSound(object)
    end

    character.DescendantAdded:Connect(function(object)
        replaceSound(object)
    end)
end

local function monitorWorkspace()
    for _, object in ipairs(Workspace:GetDescendants()) do
        replaceSound(object)
    end
end

if LocalPlayer.Character then
    scanCharacter(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(scanCharacter)

Workspace.DescendantAdded:Connect(replaceSound)

monitorWorkspace()

task.spawn(function()
    while true do
        monitorWorkspace()

        if LocalPlayer.Character then
            for _, object in ipairs(LocalPlayer.Character:GetDescendants()) do
                replaceSound(object)
            end
        end

        task.wait(0.1)
    end
end)