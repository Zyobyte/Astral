-- Yes, I know This Is Great.
local PLAYER = game.Players.LocalPlayer
local CurrentCam  = game.Workspace.CurrentCamera
local UIS = game:GetService("UserInputService")-- Made By Mick Gordon
local WorldToViewportPoint = CurrentCam.WorldToViewportPoint
local mouseLocation = UIS.GetMouseLocation

getgenv().EspEnabled = false
getgenv().TracersEnabled = false
getgenv().NameEnabled = false
getgenv().DistanceEnabled = false
getgenv().HealthEnabled = false
getgenv().SimpleEnabled = false
getgenv().BoxColor = Color3.fromRGB(255,255,255)
getgenv().TracerColor = Color3.fromRGB(255,255,255)

local DeleteMob ={
	GUi = {
		OpenNCloseButton = true; -- Have A Button For It
		KeybindEnable = false; -- If You Want A Bind For The Menu
		Keybind = "z"; -- Menu Key Bind
	};
	Aimbot= {
		Keybind = "MouseButton2"; -- Change Aim Bot Key Bind Here !!! No Capitals, Unless it is MouseButton1 or MouseButton2
		------------------------------------------------------------------------------------------
		Enabled = false; -- No Need To Change Anything Here As It Is On The GUI
		TeamCheck = false;
		WallCheck = false;
		ShowFov = false;
		Fov = 0;
		Smoothing = 0;
		AimPart = "Head";
		Thickness = 1;
		FovFillColor = Color3.fromRGB(255,255,255);
		FovColor = Color3.fromRGB(255,255,255);
		FovFillTransparency = 1;
		FovTransparenct = 0;
		IsAimKeyDown = false;
	};
	ESP ={
		Box = {
			Box = false;
			Name = false;
			Distance = false;
			Health = false;

			TeamCheck = false;

			HealthType = "Bar";

			BoxColor = Color3.fromRGB(255,255,255);
		};
		OutLines = {
			Enabled = false;
			TeamCheck = false;
			TeamColor = false;

			AllwaysShow = true;

			FillCollor = Color3.fromRGB(255,255,255);
			FillTrancparenct = 0;

			OutlineColor = Color3.fromRGB(255,255,255);
			OutlineTrancparency = 0;
		};
		Tracers = {
			Enabled = false;
			TeamCheck = false;
			TeamColor = false;

			Color = Color3.fromRGB(255,255,255);
		}
	}-- Made By Mick Gordon
}

--[[
getgenv().EspEnabled = false
getgenv().TracersEnabled = false
getgenv().NameEnabled = false
getgenv().DistanceEnabled = false
getgenv().BoxColor = Color3.fromRGB(255,255,255)
getgenv().TracerColor = Color3.fromRGB(255,255,255)
]]



-- Made By Mick Gordon
local Fov = Instance.new("ScreenGui")Fov.Name = "Fov" Fov.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") Fov.ZIndexBehavior = Enum.ZIndexBehavior.Sibling Fov.ResetOnSpawn = false-- i miss you synapse fov
local TracersG = Instance.new("ScreenGui")TracersG.Name = "Tracers" TracersG.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") TracersG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling TracersG.ResetOnSpawn = false
local FOVFFrame = Instance.new("Frame")FOVFFrame.Parent = Fov FOVFFrame.Name = "FOVFFrame" FOVFFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255) FOVFFrame.BorderColor3 = Color3.fromRGB(0, 0, 0) FOVFFrame.BorderSizePixel = 0 FOVFFrame.BackgroundTransparency = 1 FOVFFrame.AnchorPoint = Vector2.new(0.5, 0.5) FOVFFrame.Position = UDim2.new(0.5, 0,0.5, 0) FOVFFrame.Size = UDim2.new(0, DeleteMob.Aimbot.Fov, 0, DeleteMob.Aimbot.Fov) FOVFFrame.BackgroundTransparency = 1 
local UICorner = Instance.new("UICorner")UICorner.CornerRadius = UDim.new(1, 0) UICorner.Parent = FOVFFrame -- Made By Mick Gordon
local UIStroke = Instance.new("UIStroke")UIStroke.Color = Color3.fromRGB(100,0,100) UIStroke.Parent = FOVFFrame UIStroke.Thickness = 1 UIStroke.ApplyStrokeMode = "Border" 
local BoxC = Instance.new("ScreenGui", game.Workspace) BoxC.Name = "Box"
local Higlight = Instance.new("ScreenGui",game.Workspace)
local connections = {}
-- Made By Mick Gordon
local function AddHighlight(plr)
	local Highlight = Instance.new("Highlight")
	Highlight.Parent = Higlight
	Highlight.Name = plr.Name
	Highlight.Enabled = DeleteMob.ESP.OutLines.Enabled
	local plrchar = plr.Character
	if plrchar then
		Highlight.Adornee = plrchar
	end
	connections[plr] = plr.CharacterAdded:Connect(function(char)
		Highlight.Adornee = char
	end)
	local co = coroutine.create(function()
		while wait(.1) do
			if plr ~= PLAYER and plr and plr.Character and plr.Character.FindFirstChild(plr.Character, "Humanoid") and plr.Character.Humanoid.Health > 0 then
				if plr.Character:FindFirstChild("HumanoidRootPart") then
					if DeleteMob.ESP.OutLines.Enabled == true then
						if DeleteMob.ESP.OutLines.TeamCheck == true and plr.TeamColor == PLAYER.TeamColor then
							Highlight.Enabled = false
						else
							Highlight.Enabled = true
						end
					else-- Made By Mick Gordon
						Highlight.Enabled = false
					end

					if DeleteMob.ESP.OutLines.TeamColor == true then
						Highlight.FillColor = plr.TeamColor.Color 
					else
						Highlight.FillColor = DeleteMob.ESP.OutLines.FillCollor
					end

					if DeleteMob.ESP.OutLines.AllwaysShow == true then
						Highlight.DepthMode = "AlwaysOnTop" 
					else
						Highlight.DepthMode = "Occluded" 
					end-- Made By Mick Gordon

					Highlight.OutlineTransparency = DeleteMob.ESP.OutLines.OutlineTrancparency
					Highlight.OutlineColor = DeleteMob.ESP.OutLines.OutlineColor
					Highlight.FillTransparency = DeleteMob.ESP.OutLines.FillTrancparenct

					if not (game:GetService"Players":FindFirstChild(plr.Name)) then
						Higlight:FindFirstChild(plr.Name):Destroy()
						coroutine.yield()
					end
				else
					Highlight.Enabled = false
				end
			end
		end
	end)
	coroutine.resume(co)
end
-- Made By Mick Gordon
local function AddBox(player) -- Saves FPS 
	local bbg = Instance.new("BillboardGui", BoxC)
	bbg.Name = player.Name
	bbg.AlwaysOnTop = true
	bbg.Size = UDim2.new(4,0,5.4,0)
	bbg.ClipsDescendants = false
	bbg.Enabled = false

	local outlines = Instance.new("Frame", bbg)
	outlines.Size = UDim2.new(1,0,1,0)
	outlines.BorderSizePixel = 1
	outlines.BackgroundTransparency = 1
	local left = Instance.new("Frame", outlines)
	left.BorderSizePixel = 1
	left.Size = UDim2.new(0,(1),1,0)
	local right = left:Clone()
	right.Parent = outlines
	right.Size = UDim2.new(0,-(1),1,0)   
	right.Position = UDim2.new(1,0,0,0)
	local up = left:Clone()-- Made By Mick Gordon
	up.Parent = outlines
	up.Size = UDim2.new(1,0,0,(1))
	local down = left:Clone()
	down.Parent = outlines
	down.Size = UDim2.new(1,0,0,-(1))
	down.Position = UDim2.new(0,0,1,0)

	local info = Instance.new("BillboardGui", bbg)
	info.Name = "info"
	info.Size = UDim2.new(3,0,0,54)
	info.StudsOffset = Vector3.new(3.6,-3,0)
	info.AlwaysOnTop = true
	info.ClipsDescendants = false
	info.Enabled = false
	local namelabel = Instance.new("TextLabel", info)
	namelabel.Name = "namelabel"
	namelabel.BackgroundTransparency = 1
	namelabel.TextStrokeTransparency = 0
	namelabel.TextXAlignment = Enum.TextXAlignment.Left
	namelabel.Size = UDim2.new(0,100,0,18)
	namelabel.Position = UDim2.new(0,0,0,0)
	namelabel.Text = player.Name
	local distancel = Instance.new("TextLabel", info)
	distancel.Name = "distancelabel"
	distancel.BackgroundTransparency = 1-- Made By Mick Gordon
	distancel.TextStrokeTransparency = 0
	distancel.TextXAlignment = Enum.TextXAlignment.Left
	distancel.Size = UDim2.new(0,100,0,18)
	distancel.Position = UDim2.new(0,0,0,18)
	local healthl = Instance.new("TextLabel", info)
	healthl.Name = "healthlabel"
	healthl.BackgroundTransparency = 1
	healthl.TextStrokeTransparency = 0
	healthl.TextXAlignment = Enum.TextXAlignment.Left
	healthl.Size = UDim2.new(0,100,0,18)
	healthl.Position = UDim2.new(0,0,0,36)

	local uill = Instance.new("UIListLayout", info)

	local forhealth = Instance.new("BillboardGui", bbg)
	forhealth.Name = "forhealth"
	forhealth.Size = UDim2.new(4.5,0,6,0)
	forhealth.AlwaysOnTop = true
	forhealth.ClipsDescendants = false
	forhealth.Enabled = false

	local healthbar = Instance.new("Frame", forhealth)
	healthbar.Name = "healthbar"
	healthbar.BackgroundColor3 = Color3.fromRGB(40,40,40)
	healthbar.BorderColor3 = Color3.fromRGB(0,0,0)
	healthbar.Size = UDim2.new(0.04,0,0.9,0)
	healthbar.Position = UDim2.new(0,0,0.05,0)
	local bar = Instance.new("Frame", healthbar)
	bar.Name = "bar"
	bar.BorderSizePixel = 0
	bar.BackgroundColor3 = Color3.fromRGB(94,255,69)
	bar.AnchorPoint = Vector2.new(0,1)
	bar.Position = UDim2.new(0,0,1,0)
	bar.Size = UDim2.new(1,0,1,0)

	-- Made By Mick Gordon
	local co = coroutine.create(function()
		while wait(0.1) do
			if player ~= PLAYER and player and player.Character and player.Character.FindFirstChild(player.Character, "Humanoid") and player.Character.Humanoid.Health > 0 then
				if player.Character:FindFirstChild("HumanoidRootPart") then
					bbg.Adornee = player.Character.HumanoidRootPart
					info.Adornee = player.Character.HumanoidRootPart
					forhealth.Adornee = player.Character.HumanoidRootPart

					if DeleteMob.ESP.Box.Box == true then
						outlines.Visible = true
					else
						outlines.Visible = false
					end

					outlines.BackgroundTransparency = 1

					if DeleteMob.ESP.Box.Health == true then
						if player.Character:FindFirstChild("Humanoid") ~= nil then
							healthl.Text = "Health: "..math.floor(player.Character:FindFirstChild"Humanoid".Health)
							healthbar.bar.Size = UDim2.new(1,0,player.Character:FindFirstChild"Humanoid".Health/player.Character:FindFirstChild"Humanoid".MaxHealth,0)
						end
						if DeleteMob.ESP.Box.HealthType == "Text" then
							healthbar.Visible = false
							healthl.Visible = true
						end-- Made By Mick Gordon
						if DeleteMob.ESP.Box.HealthType == "Bar" then
							healthl.Visible = false
							healthbar.Visible = true
						end
						if DeleteMob.ESP.Box.HealthType == "Both" then
							healthl.Visible = true
							healthbar.Visible = true
						end
					else
						healthl.Visible = false
						healthbar.Visible = false
					end


					if DeleteMob.ESP.Box.Name then
						namelabel.Visible = true
					else
						namelabel.Visible = false
					end

					-- Made By Mick Gordon
					if DeleteMob.ESP.Box.Distance == true then
						distancel.Visible = true
						if PLAYER.Character and PLAYER.Character:FindFirstChild("HumanoidRootPart") ~= nil then
							distancel.Text = "Distance: "..math.floor(0.5+(PLAYER.Character:FindFirstChild"HumanoidRootPart".Position - player.Character:FindFirstChild"HumanoidRootPart".Position).magnitude)
						end
					else
						distancel.Visible = false
					end


					if DeleteMob.ESP.Box.TeamCheck == true and player.TeamColor == PLAYER.TeamColor then
						bbg.Enabled = false
						info.Enabled = false
						forhealth.Enabled = false
					else
						bbg.Enabled = true
						info.Enabled = true
						forhealth.Enabled = true
					end
					-- Made By Mick Gordon
					outlines.BackgroundColor3 = Color3.fromRGB(255,255,255)
					if DeleteMob.ESP.Box.TeamColor == true then
						left.BackgroundColor3 = player.TeamColor.Color
						right.BackgroundColor3 = player.TeamColor.Color
						up.BackgroundColor3 = player.TeamColor.Color
						down.BackgroundColor3 = player.TeamColor.Color
						outlines.BackgroundColor3 = Color3.fromRGB(255,255,255)
					else
						outlines.BackgroundColor3 = DeleteMob.ESP.Box.BoxColor
						left.BackgroundColor3 = DeleteMob.ESP.Box.BoxColor
						right.BackgroundColor3 = DeleteMob.ESP.Box.BoxColor
						up.BackgroundColor3 = DeleteMob.ESP.Box.BoxColor
						down.BackgroundColor3 = DeleteMob.ESP.Box.BoxColor
						healthl.TextColor3 = DeleteMob.ESP.Box.BoxColor
						distancel.TextColor3 = DeleteMob.ESP.Box.BoxColor
						namelabel.TextColor3 = Color3.fromRGB(255,255,255)
					end

					if not (game:GetService"Players":FindFirstChild(player.Name)) then
						BoxC:FindFirstChild(player.Name):Destroy()
						coroutine.yield()
					end-- Made By Mick Gordon
				end
			else
				bbg.Enabled = false
				bbg.Adornee = nil
				info.Adornee = nil
				info.Enabled = false
				forhealth.Adornee = nil
				forhealth.Enabled = false
			end
		end 
	end)
	coroutine.resume(co)
end


local function AddTracers(Player) -- Tracers Without Lib OMG !!!!
	local tracer = Instance.new("Frame") -- Idk What I Was Smoking When Making This Scrip Hub, It Is Shit And I Will Remake Later 
	tracer.Parent = TracersG
	tracer.Name = Player.Name
	tracer.Active = false
	tracer.AnchorPoint = Vector2.new(.5, .5)
	tracer.Visible = false

	local co = coroutine.create(function()
		game:GetService("RunService").RenderStepped:Connect(function()
			local function UpdateValues()
				DeleteMob.ESP.Box.Box = getgenv().EspEnabled
				DeleteMob.ESP.Box.Health = getgenv().HealthEnabled
				DeleteMob.ESP.Tracers.Enabled = getgenv().TracersEnabled
				DeleteMob.ESP.Box.Name = getgenv().NameEnabled
				DeleteMob.ESP.OutLines.Enabled = getgenv().SimpleEnabled
				DeleteMob.ESP.Box.Distance = getgenv().DistanceEnabled
				DeleteMob.ESP.Box.BoxColor = getgenv().BoxColor
				DeleteMob.ESP.Tracers.Color = getgenv().TracerColor
			end
			UpdateValues()
			if Player ~= PLAYER and Player and Player.Character and Player.Character.FindFirstChild(Player.Character, "Humanoid") and Player.Character.Humanoid.Health > 0 then
				if Player.Character:FindFirstChild("HumanoidRootPart") then
					local TargetPart = Player.Character:FindFirstChild("HumanoidRootPart")
					local ScreenPoint, OnScreen = CurrentCam:WorldToScreenPoint(TargetPart.Position)
					local distance 
					-- Made By Mick Gordon
					distance = math.floor(0.5+(game.Workspace.CurrentCamera.CFrame.Position - Player.Character:WaitForChild("HumanoidRootPart").Position).magnitude)

					local screenpointmain = Vector2.new(ScreenPoint.X, ScreenPoint.Y + (2500 / distance)) --  / distance so it can be at the bottom of the box.
					local posd = UIS:GetMouseLocation()
					local MouseOrigin = Vector2.new(posd.X, posd.Y - 36)
					local Origin = Vector2.new(CurrentCam.ViewportSize.X/2, CurrentCam.ViewportSize.Y - 1)
					local Position = (Origin + screenpointmain) / 2
					local Length = (Origin - screenpointmain).Magnitude
					tracer.Rotation = math.deg(math.atan2(screenpointmain.Y - Origin.Y, screenpointmain.X - Origin.X))


					Position = (Origin + screenpointmain) / 2
					Length = (Origin - screenpointmain).Magnitude
					tracer.Rotation = math.deg(math.atan2(screenpointmain.Y - Origin.Y, screenpointmain.X - Origin.X))


					if OnScreen then
						if DeleteMob.ESP.Tracers.Enabled == true and OnScreen then
							if DeleteMob.ESP.Tracers.TeamCheck == true then
								if Player.TeamColor == PLAYER.TeamColor then
									tracer.Visible = false
								else
									tracer.Visible = true
								end
							else -- Made By Mick Gordon
								tracer.Visible = true
							end
						else
							tracer.Visible = false
						end-- Made By Mick Gordon

						if DeleteMob.ESP.Tracers.TeamColor == true then
							tracer.BackgroundColor3 = Player.TeamColor.Color
						else
							tracer.BackgroundColor3 = DeleteMob.ESP.Tracers.Color
						end

						tracer.BorderColor3 = Color3.fromRGB(27, 42, 53)
						tracer.Position = UDim2.new(0, Position.X, 0, Position.Y)
						tracer.Size = UDim2.new(0, Length, 0, 2)
					else
						tracer.Visible = false
					end

					if not (game:GetService"Players":FindFirstChild(Player.Name)) then
						Fov:FindFirstChild(Player.Name):Destroy()
						coroutine.yield()
					end
				end
			else
				tracer.Visible = false
			end
		end)
	end)
	coroutine.resume(co)-- Made By Mick Gordon
end

function isVisible(p, ...)

	if not (DeleteMob.Aimbot.WallCheck == true) then
		return true
	end

	return #CurrentCam:GetPartsObscuringTarget({ p }, { CurrentCam, PLAYER.Character, ... }) == 0 
end-- Made By Mick Gordon

function CameraGetClosestToMouse(Fov)
	local AimFov = Fov
	local targetPos = nil

	for i,v in pairs (game:GetService("Players"):GetPlayers()) do
		if v ~= PLAYER then
			if DeleteMob.Aimbot.TeamCheck == true then
				if v.Character and v.Character:FindFirstChild(DeleteMob.Aimbot.AimPart) and v.Character.Humanoid and v.Character.Humanoid.Health > 0 and not (v.Team == PLAYER.Team) then
					local screen_pos, on_screen = WorldToViewportPoint(CurrentCam, v.Character[DeleteMob.Aimbot.AimPart].Position)
					local screen_pos_2D = Vector2.new(screen_pos.X, screen_pos.Y)
					local new_magnitude = (screen_pos_2D - mouseLocation(UIS)).Magnitude
					if on_screen and new_magnitude < AimFov and isVisible(v.Character[DeleteMob.Aimbot.AimPart].Position, v.Character.Head.Parent) then
						AimFov = new_magnitude
						targetPos = v-- Made By Mick Gordon
					end
				end-- Made By Mick Gordon
			else
				if v.Character and v.Character:FindFirstChild(DeleteMob.Aimbot.AimPart) and v.Character.Humanoid and v.Character.Humanoid.Health > 0 then
					local screen_pos, on_screen = WorldToViewportPoint(CurrentCam, v.Character[DeleteMob.Aimbot.AimPart].Position)
					local screen_pos_2D = Vector2.new(screen_pos.X, screen_pos.Y)
					local new_magnitude = (screen_pos_2D - mouseLocation(UIS)).Magnitude
					if on_screen and new_magnitude < AimFov and isVisible(v.Character[DeleteMob.Aimbot.AimPart].Position, v.Character.Head.Parent) then
						AimFov = new_magnitude
						targetPos = v
					end
				end
			end
		end
	end
	return targetPos
end


local function aimAt(pos, smooth)
	local AimPart = pos.Character:FindFirstChild(DeleteMob.Aimbot.AimPart)
	if AimPart then
		local LookAt = nil
		local Distance = math.floor(0.5+(PLAYER.Character:FindFirstChild"HumanoidRootPart".Position - pos.Character:FindFirstChild"HumanoidRootPart".Position).magnitude)
		if Distance > 100  then
			local distChangeBig = Distance / 10
			LookAt = CurrentCam.CFrame:PointToWorldSpace(Vector3.new(0,0,-smooth * distChangeBig)):Lerp(AimPart.Position,.01) -- No one esle do camera smoothing ? tf
		else-- Made By Mick Gordon
			local distChangeSmall = Distance / 10
			LookAt = CurrentCam.CFrame:PointToWorldSpace(Vector3.new(0,0,-smooth * distChangeSmall)):Lerp(AimPart.Position,.01) -- No one esle do camera smoothing ? tf
		end
		CurrentCam.CFrame = CFrame.lookAt(CurrentCam.CFrame.Position, LookAt)
	end
end

-- Cant Be Botherd To Clean This Up
local CheatEngineDeleteMob = Instance.new("ScreenGui")
local DeleteMobF = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local Name = Instance.new("TextLabel")
local Line = Instance.new("Frame")
local Line_2 = Instance.new("Frame")
local AimBotSection = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local ABE = Instance.new("TextButton")
local ABWC = Instance.new("TextButton")
local ABTC = Instance.new("TextButton")
local ABSF = Instance.new("TextButton")
local Frame = Instance.new("Frame")
local Slider3 = Instance.new("Frame")-- Made By Mick Gordon
local UICorner = Instance.new("UICorner")
local Fill1 = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local TriggerFov = Instance.new("TextButton")
local Numbers = Instance.new("TextLabel")
local TextLabel = Instance.new("TextLabel")
local Frame_2 = Instance.new("Frame")
local Slider4 = Instance.new("Frame")
local UICorner_3 = Instance.new("UICorner")
local Fill2 = Instance.new("Frame")
local UICorner_4 = Instance.new("UICorner")
local UIGradient_2 = Instance.new("UIGradient")
local TriggerSmoothing = Instance.new("TextButton")-- Made By Mick Gordon
local Numbers_2 = Instance.new("TextLabel")
local TextLabel_2 = Instance.new("TextLabel")
local TextLabel_3 = Instance.new("TextLabel")
local Allways_Show = Instance.new("TextButton")
local TextLabel_4 = Instance.new("TextLabel")
local ESPSection = Instance.new("Frame")
local UIListLayout_2 = Instance.new("UIListLayout")
local BBE = Instance.new("TextButton")
local BTC = Instance.new("TextButton")
local BBN = Instance.new("TextButton")
local BBD = Instance.new("TextButton")
local BBH = Instance.new("TextButton")
local TextLabel_5 = Instance.new("TextLabel")
local BBHT = Instance.new("TextButton")
local TextLabel_6 = Instance.new("TextLabel")
local TextLabel_7 = Instance.new("TextLabel")
local Frame_3 = Instance.new("Frame")
local UIListLayout_3 = Instance.new("UIListLayout")
local Box_R = Instance.new("TextBox")
local Box_G = Instance.new("TextBox")
local Box_B = Instance.new("TextBox")
local TextLabel_8 = Instance.new("TextLabel")
local ESPSection_2 = Instance.new("Frame")
local UIListLayout_4 = Instance.new("UIListLayout")
local OE = Instance.new("TextButton")
local OTC = Instance.new("TextButton")-- Made By Mick Gordon
local Frame_4 = Instance.new("Frame")
local Slider1 = Instance.new("Frame")
local UICorner_5 = Instance.new("UICorner")
local Fill3 = Instance.new("Frame")
local UICorner_6 = Instance.new("UICorner")
local UIGradient_3 = Instance.new("UIGradient")
local TriggerOutTans = Instance.new("TextButton")
local Numbers_3 = Instance.new("TextLabel")
local TextLabel_9 = Instance.new("TextLabel")
local Frame_5 = Instance.new("Frame")
local Slider2 = Instance.new("Frame")
local UICorner_7 = Instance.new("UICorner")
local Fill4 = Instance.new("Frame")
local UICorner_8 = Instance.new("UICorner")
local UIGradient_4 = Instance.new("UIGradient")
local TriggerFill = Instance.new("TextButton")
local Numbers_4 = Instance.new("TextLabel")
local TextLabel_10 = Instance.new("TextLabel")
local TextLabel_11 = Instance.new("TextLabel")
local Frame_6 = Instance.new("Frame")
local UIListLayout_5 = Instance.new("UIListLayout")
local Outlines_R = Instance.new("TextBox")
local Outlines_G = Instance.new("TextBox")
local Outlines_B = Instance.new("TextBox")
local TextLabel_12 = Instance.new("TextLabel")
local Frame_7 = Instance.new("Frame")
local UIListLayout_6 = Instance.new("UIListLayout")
local FillOutlines_R = Instance.new("TextBox")
local FillOutlines_G = Instance.new("TextBox")
local FillOutlines_B = Instance.new("TextBox")
local Tracerssection = Instance.new("Frame")
local UIListLayout_7 = Instance.new("UIListLayout")
local TE = Instance.new("TextButton")
local TTC = Instance.new("TextButton")
local TTCOlor = Instance.new("TextButton")
local Frame_8 = Instance.new("Frame")
local UIListLayout_8 = Instance.new("UIListLayout")
local Tracers_R = Instance.new("TextBox")
local Tracers_G = Instance.new("TextBox")
local Tracers_B = Instance.new("TextBox")-- Made By Mick Gordon
local Unknown = Instance.new("Frame")
local UIListLayout_9 = Instance.new("UIListLayout")
local TextLabel_13 = Instance.new("TextLabel")
local TextLabel_14 = Instance.new("TextLabel")
local Open = Instance.new("Frame")
local TextButton = Instance.new("TextButton")

game:GetService('RunService').RenderStepped:connect(function()

	-- Aimbot Check
	if DeleteMob.Aimbot.IsAimKeyDown then
		local _pos = CameraGetClosestToMouse(DeleteMob.Aimbot.Fov)
		if _pos then
			aimAt(_pos, DeleteMob.Aimbot.Smoothing)
		end
	end

	-- Fov
	local acc = DeleteMob.Aimbot.Smoothing / 2	
	local posd = UIS:GetMouseLocation() 
	FOVFFrame.Position = UDim2.new(0, posd.X, 0, posd.Y - 36)
	FOVFFrame.Size = UDim2.new(0, DeleteMob.Aimbot.Fov + acc, 0, DeleteMob.Aimbot.Fov + acc)
	FOVFFrame.Visible = DeleteMob.Aimbot.ShowFov
	FOVFFrame.BackgroundColor3 = DeleteMob.Aimbot.FovFillColor
	FOVFFrame.Transparency = DeleteMob.Aimbot.FovFillTransparency

	UIStroke.Color = DeleteMob.Aimbot.FovFillColor
	UIStroke.Transparency = DeleteMob.Aimbot.FovTransparenct
	UIStroke.Thickness = DeleteMob.Aimbot.Thickness

	-- Colors 
end)


task.wait()

for i,plr in pairs(game.Players:GetChildren()) do
	AddHighlight(plr)
	AddBox(plr)
	AddTracers(plr)
end

game.Players.PlayerAdded:Connect(function(plr)
	AddHighlight(plr)
	AddBox(plr)
	AddTracers(plr)
end)
