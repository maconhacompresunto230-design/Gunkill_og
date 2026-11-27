local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

local NEW_KILL_ID = "296102734"
local GUN_KILL_ID = "94652054872987"

local connections = {}

local function configureSound(sound)
    if not sound:IsA("Sound") then
        return
    end

    local function updateSound()
        local id = sound.SoundId:match("%d+") or ""
        local name = sound.Name:lower()

        if id == NEW_KILL_ID or name:find("GunKill") then
            if id == NEW_KILL_ID then
                sound.SoundId = "rbxassetid://" .. GUN_KILL_ID
            end
        end
    end

    updateSound()

    if connections[sound] then
        return
    end

    connections[sound] = true

    sound:GetPropertyChangedSignal("SoundId"):Connect(updateSound)
    sound:GetPropertyChangedSignal("Name"):Connect(updateSound)
end

local function scan(container)
    for _, object in ipairs(container:GetDescendants()) do
        configureSound(object)
    end
end

Workspace.DescendantAdded:Connect(configureSound)
LocalPlayer.DescendantAdded:Connect(configureSound)

scan(Workspace)
scan(LocalPlayer)

LocalPlayer.CharacterAdded:Connect(function(character)
    scan(character)
    character.DescendantAdded:Connect(configureSound)
end)

if LocalPlayer.Character then
    scan(LocalPlayer.Character)
end