local P,W,R=game:GetService("Players"),game:GetService("Workspace"),game:GetService("RunService")
local LP=P.LocalPlayer
local On,Rad,Min,t=false,100,false,0

local SG=Instance.new("ScreenGui",game:GetService("CoreGui") or LP:WaitForChild("PlayerGui"))
local MF=Instance.new("Frame",SG)
MF.Size,MF.Position,MF.BackgroundColor3,MF.Active,MF.Draggable=UDim2.new(0,200,0,130),UDim2.new(0.05,0,0.2,0),Color3.fromRGB(25,25,25),true,true

local TB=Instance.new("Frame",MF)
TB.Size,TB.BackgroundColor3=UDim2.new(1,0,0,30),Color3.fromRGB(15,15,15)
local TL=Instance.new("TextLabel",TB)
TL.Size,TL.Text,TL.TextColor3,TL.BackgroundTransparency=UDim2.new(0.7,0,1,0),"ETW Magnet",Color3.fromRGB(255,140,0),1

local MB=Instance.new("TextButton",TB)
MB.Size,MB.Position,MB.Text,MB.BackgroundColor3,MB.TextColor3=UDim2.new(0,25,0,20),UDim2.new(1,-28,0,5),"-",Color3.fromRGB(60,60,60),Color3.new(1,1,1)
local B1=Instance.new("TextButton",MF)
B1.Size,B1.Position,B1.Text,B1.BackgroundColor3,B1.TextColor3=UDim2.new(0.9,0,0,35),UDim2.new(0.05,0,0.28,0),"Hút Kẹo: OFF",Color3.fromRGB(180,50,50),Color3.new(1,1,1)
local B2=Instance.new("TextButton",MF)
B2.Size,B2.Position,B2.Text,B2.BackgroundColor3,B2.TextColor3=UDim2.new(0.9,0,0,35),UDim2.new(0.05,0,0.62,0),"Bán Kính: 100m",Color3.fromRGB(50,50,50),Color3.new(1,1,1)

local function isCandyPart(v)
    if not v or not v:IsA("BasePart") then return false end
    local name = v.Name:lower()
    return name:find("candy") or name:find("sweet") or name:find("coin") or name:find("orb") or name:find("gem")
end

MB.MouseButton1Click:Connect(function()
    Min=not Min
    B1.Visible,B2.Visible,MB.Text=not Min,not Min,Min and "+" or "-"
    MF.Size=Min and UDim2.new(0,200,0,30) or UDim2.new(0,200,0,130)
end)

B2.MouseButton1Click:Connect(function()
    Rad=Rad==100 and 300 or Rad==300 and 500 or Rad==500 and 1000 or 100
    B2.Text="Bán Kính: "..Rad.."m"
end)

B1.MouseButton1Click:Connect(function()
    On=not On
    B1.Text=On and "Hút Kẹo: ON" or "Hút Kẹo: OFF"
    B1.BackgroundColor3=On and Color3.fromRGB(50,180,50) or Color3.fromRGB(180,50,50)
end)

R.RenderStepped:Connect(function(dt)
    t=t+dt
    if On and t>=0.05 then
        t=0
        local c=LP.Character
        if c and c:FindFirstChild("HumanoidRootPart") then
            local hrp=c.HumanoidRootPart
            local p=hrp.Position
            for _,v in ipairs(W:GetDescendants()) do
                if isCandyPart(v) then
                    local dist=(v.Position-p).Magnitude
                    if dist <= Rad then
                        local targetPos = hrp.CFrame.Position + Vector3.new(0, 2, 0)
                        v.CFrame = v.CFrame:Lerp(CFrame.new(targetPos), 0.5)
                        if dist < 3 then
                            v.CFrame = CFrame.new(p + Vector3.new(math.random(-1,1), 0, math.random(-1,1)))
                        end
                    end
                end
            end
        end
    end
end)