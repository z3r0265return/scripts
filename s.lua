local uis = game:GetService("UserInputService")
local toggled = false

uis.InputBegan:Connect(function(input, gpe)
    if gpe then return end

    if input.KeyCode == Enum.KeyCode.Y then
        toggled = not toggled
    elseif toggled and input.UserInputType == Enum.UserInputType.MouseButton2 then
        game:GetService("Players").LocalPlayer.Character.Combat.RemoteEvent:FireServer("Input", "Yorick's Wicked Magic", 5, "Barrage")
    end
end)
