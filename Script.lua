local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local NEW_SOUND_ID = "rbxassetid://137812518234654"

local function replaceSound(sound)
    if sound:IsA("Sound") and sound.Name == "GunKill" then
        sound.SoundId = NEW_SOUND_ID
        sound.Volume = 2
    end
end

local function scanCharacter(character)
    for _, object in ipairs(character:GetDescendants()) do
        replaceSound(object)
    end

    character.DescendantAdded:Connect(replaceSound)
end

if LocalPlayer.Character then
    scanCharacter(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(scanCharacter)

Workspace.DescendantAdded:Connect(replaceSound)

for _, object in ipairs(Workspace:GetDescendants()) do
    replaceSound(object)
end