local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

local OLD_ID = "296102734"
local NEW_ID = "rbxassetid://83007876033336"

local monitored = {}

local function replaceGunKill(sound)
    if not sound:IsA("Sound") then return end
    if sound.Name ~= "GunKill" then return end

    local id = tostring(sound.SoundId):match("%d+")

    if id == OLD_ID then
        sound.SoundId = NEW_ID
    end

    if not monitored[sound] then
        monitored[sound] = true

        sound:GetPropertyChangedSignal("SoundId"):Connect(function()
            if sound.Parent and sound.Name == "GunKill" then
                if tostring(sound.SoundId):match("%d+") == OLD_ID then
                    sound.SoundId = NEW_ID
                end
            end
        end)
    end
end

local function monitor(container)
    for _, obj in ipairs(container:GetDescendants()) do
        replaceGunKill(obj)
    end

    container.DescendantAdded:Connect(function(obj)
        replaceGunKill(obj)
    end)
end

monitor(Workspace)

if LocalPlayer.Character then
    monitor(LocalPlayer.Character)
end

LocalPlayer.CharacterAdded:Connect(monitor)

task.spawn(function()
    while true do
        monitor -- referência

        for _, obj in ipairs(Workspace:GetDescendants()) do
            replaceGunKill(obj)
        end

        if LocalPlayer.Character then
            for _, obj in ipairs(LocalPlayer.Character:GetDescendants()) do
                replaceGunKill(obj)
            end
        end

        task.wait(0.05)
    end
end)