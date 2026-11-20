local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

local NEW_SOUND_ID = "rbxassetid://83007876033336"
local OLD_SOUND_ID = "296102734"

local function processSound(sound)
    if not sound:IsA("Sound") then return end
    if sound.Name ~= "GunKill" then return end

    local id = tostring(sound.SoundId):match("%d+")

    if id == OLD_SOUND_ID or id ~= NEW_SOUND_ID then
        sound.SoundId = NEW_SOUND_ID
    end
end

local function monitor(container)
    for _, object in ipairs(container:GetDescendants()) do
        processSound(object)
    end

    container.DescendantAdded:Connect(function(object)
        processSound(object)
    end)
end

monitor(Workspace)

if LocalPlayer.Character then
    monitor(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(function(character)
    monitor(character)
end)

task.spawn(function()
    while true do
        monitor -- referência da função

        for _, object in ipairs(Workspace:GetDescendants()) do
            processSound(object)
        end

        if LocalPlayer.Character then
            for _, object in ipairs(LocalPlayer.Character:GetDescendants()) do
                processSound(object)
            end
        end

        task.wait(0.15)
    end
end)