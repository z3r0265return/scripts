local PathfindingService = game:GetService("PathfindingService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local nam = {
	"voidkidd", "rektmaster", "drippyzz", "notyou", "xX_Pro_Xx",
	"fakeuser420", "noobslayer", "guest666", "jesusisthellord3911", "spunkifann39"
}

local messages = {
	"yo anyone got robux?",
	"lmao ez",
	"i'm better than u fr",
	"this game trash",
	"bruh moment",
	"sub to team v0idkidd"
}

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local tool = Instance.new("Tool")
tool.Name = "Bot Spawner"
tool.RequiresHandle = false
tool.Parent = player.Backpack

local function createPart(name, size, position, parent)
	local part = Instance.new("Part")
	part.Name = name
	part.Size = size
	part.Position = position
	part.Anchored = false
	part.CanCollide = true
	part.BrickColor = BrickColor.new("Bright blue")
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	part.Parent = parent
	return part
end

local function weld(p0, p1)
	local w = Instance.new("WeldConstraint")
	w.Part0 = p0
	w.Part1 = p1
	w.Parent = p0
end

local function sayRandomMessage(head)
	local msg = Instance.new("BillboardGui", head)
	msg.Size = UDim2.new(0, 200, 0, 50)
	msg.StudsOffset = Vector3.new(0, 3, 0)
	msg.AlwaysOnTop = true

	local txt = Instance.new("TextLabel", msg)
	txt.Size = UDim2.new(1, 0, 1, 0)
	txt.BackgroundTransparency = 1
	txt.TextColor3 = Color3.new(1, 1, 1)
	txt.TextStrokeTransparency = 0
	txt.Font = Enum.Font.SourceSans
	txt.TextScaled = true
	txt.Text = messages[math.random(1, #messages)]

	Debris:AddItem(msg, 3)
end

local function spawnBot(pos)
	local model = Instance.new("Model", workspace)
	model.Name = "FakePlayer"

	local humanoid = Instance.new("Humanoid")
	humanoid.Parent = model

	local torso = createPart("Torso", Vector3.new(2, 2, 1), pos, model)
	local head = createPart("Head", Vector3.new(2, 1, 1), pos + Vector3.new(0, 1.5, 0), model)
	local leftArm = createPart("Left Arm", Vector3.new(1, 2, 1), pos + Vector3.new(-1.5, 0, 0), model)
	local rightArm = createPart("Right Arm", Vector3.new(1, 2, 1), pos + Vector3.new(1.5, 0, 0), model)
	local leftLeg = createPart("Left Leg", Vector3.new(1, 2, 1), pos + Vector3.new(-0.5, -2, 0), model)
	local rightLeg = createPart("Right Leg", Vector3.new(1, 2, 1), pos + Vector3.new(0.5, -2, 0), model)

	weld(torso, head)
	weld(torso, leftArm)
	weld(torso, rightArm)
	weld(torso, leftLeg)
	weld(torso, rightLeg)

	model.PrimaryPart = torso
	model:SetPrimaryPartCFrame(CFrame.new(pos))

	local nameGui = Instance.new("BillboardGui", head)
	nameGui.Size = UDim2.new(0, 200, 0, 50)
	nameGui.StudsOffset = Vector3.new(0, 2, 0)
	nameGui.AlwaysOnTop = true

	local nameText = Instance.new("TextLabel", nameGui)
	nameText.Size = UDim2.new(1, 0, 1, 0)
	nameText.BackgroundTransparency = 1
	nameText.TextColor3 = Color3.new(1, 1, 1)
	nameText.TextStrokeTransparency = 0
	nameText.Font = Enum.Font.SourceSansBold
	nameText.TextScaled = true
	nameText.Text = nam[math.random(1, #nam)]

	task.spawn(function()
		while model and model.Parent do
			local goal = torso.Position + Vector3.new(math.random(-30,30), 0, math.random(-30,30))
			local path = PathfindingService:CreatePath()
			path:ComputeAsync(torso.Position, goal)

			if path.Status == Enum.PathStatus.Complete then
				for _, waypoint in ipairs(path:GetWaypoints()) do
					humanoid:MoveTo(waypoint.Position)
					humanoid.MoveToFinished:Wait()
				end
			end

			if math.random(1, 3) == 1 then
				sayRandomMessage(head)
			end

			task.wait(3)
		end
	end)
end

tool.Activated:Connect(function()
	local hit = mouse.Hit
	if hit then
		spawnBot(hit.Position + Vector3.new(0, 3, 0))
	end
end)
