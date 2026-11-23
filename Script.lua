local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local NEW_SOUND_ID = "rbxassetid://137812518234654"

local function replaceSound(sound)
    if not sound:IsA("Sound") or sound.Name ~= "GunKill" then
        return
    end

    if sound.SoundId:match("%d+") == "296102734" then
        sound.Volume = 0
        sound:Stop()
        return
    end

    sound.SoundId = NEW_SOUND_ID
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