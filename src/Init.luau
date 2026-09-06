--!strict
-- AWolf UI Library Framework
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

local AWolf = {
	Version = "1.0.0",
	Options = {},
	Toggles = {},
}

-- Lucide Icon Fetcher Helper
local LucideModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/lucide-icons/lucide-roblox/main/src/init.luau"))()

local function GetLucideIcon(iconName: string): string
	return LucideModule.get(iconName:lower()) or "rbxassetid://10709782497"
end

function AWolf:CreateWindow(Config: { Title: string?, Footnote: string? })
	Config = Config or {}

	-- Main ScreenGui Container
	local WolfUI = Instance.new("ScreenGui")
	WolfUI.Name = "AWolfUI"
	WolfUI.ResetOnSpawn = false
	WolfUI.Parent = CoreGui

	-- Main UI Frame
	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	MainFrame.BackgroundTransparency = 0.3
	MainFrame.BorderSizePixel = 0
	MainFrame.Position = UDim2.fromScale(0.5, 0.5)
	MainFrame.Size = UDim2.fromOffset(680, 420)
	MainFrame.Parent = WolfUI

	-- Top Header Bar
	local HeaderFrame = Instance.new("Frame")
	HeaderFrame.Name = "HeaderFrame"
	HeaderFrame.Size = UDim2.new(1, 0, 0, 48)
	HeaderFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	HeaderFrame.BackgroundTransparency = 0.5
	HeaderFrame.BorderSizePixel = 0
	HeaderFrame.Parent = MainFrame

	local HeaderTitle = Instance.new("TextLabel")
	HeaderTitle.Name = "HeaderTitle"
	HeaderTitle.Position = UDim2.fromOffset(180, 0)
	HeaderTitle.Size = UDim2.fromOffset(140, 48)
	HeaderTitle.Font = Enum.Font.Code
	HeaderTitle.Text = Config.Title or " WolfTool"
	HeaderTitle.TextColor3 = Color3.fromRGB(130, 6, 6)
	HeaderTitle.TextSize = 24
	HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
	HeaderTitle.BackgroundTransparency = 1
	HeaderTitle.Parent = HeaderFrame

	local SearchBox = Instance.new("TextBox")
	SearchBox.Name = "SearchBox"
	SearchBox.Position = UDim2.fromOffset(425, 7)
	SearchBox.Size = UDim2.fromOffset(114, 35)
	SearchBox.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
	SearchBox.Font = Enum.Font.Code
	SearchBox.PlaceholderColor3 = Color3.fromRGB(80, 80, 80)
	SearchBox.PlaceholderText = "🔍 Search..."
	SearchBox.Text = ""
	SearchBox.TextSize = 12
	SearchBox.Parent = HeaderFrame

	local SearchCorner = Instance.new("UICorner")
	SearchCorner.CornerRadius = UDim.new(0, 5)
	SearchCorner.Parent = SearchBox

	local LockButton = Instance.new("TextButton")
	LockButton.Name = "LockButton"
	LockButton.Position = UDim2.fromOffset(556, 12)
	LockButton.Size = UDim2.fromOffset(60, 26)
	LockButton.BackgroundColor3 = Color3.fromRGB(130, 6, 6)
	LockButton.Font = Enum.Font.Code
	LockButton.Text = "LOCK"
	LockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	LockButton.TextSize = 12
	LockButton.Parent = HeaderFrame

	local LockCorner = Instance.new("UICorner")
	LockCorner.CornerRadius = UDim.new(0, 5)
	LockCorner.Parent = LockButton

	local DragIcon = Instance.new("ImageLabel")
	DragIcon.Name = "DragIcon"
	DragIcon.Position = UDim2.fromOffset(625, 2)
	DragIcon.Size = UDim2.fromOffset(45, 45)
	DragIcon.BackgroundTransparency = 1
	DragIcon.Image = GetLucideIcon("move")
	DragIcon.ImageColor3 = Color3.fromRGB(130, 6, 6)
	DragIcon.Parent = HeaderFrame

	-- Left Sidebar
	local Sidebar = Instance.new("Frame")
	Sidebar.Name = "Sidebar"
	Sidebar.Position = UDim2.fromOffset(0, 0)
	Sidebar.Size = UDim2.new(0, 180, 1, -25)
	Sidebar.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
	Sidebar.BackgroundTransparency = 0.4
	Sidebar.BorderSizePixel = 0
	Sidebar.Parent = MainFrame

	-- Profile Card
	local ProfileCard = Instance.new("Frame")
	ProfileCard.Name = "ProfileCard"
	ProfileCard.Size = UDim2.new(1, 0, 0, 90)
	ProfileCard.BackgroundColor3 = Color3.fromRGB(25, 25, 27)
	ProfileCard.BackgroundTransparency = 0.25
	ProfileCard.BorderSizePixel = 0
	ProfileCard.Parent = Sidebar

	local Avatar = Instance.new("ImageLabel")
	Avatar.Name = "Avatar"
	Avatar.Position = UDim2.fromOffset(10, 15)
	Avatar.Size = UDim2.fromOffset(40, 40)
	Avatar.BackgroundTransparency = 1
	Avatar.Image = GetLucideIcon("user")
	Avatar.Parent = ProfileCard

	local Playername = Instance.new("TextLabel")
	Playername.Name = "Playername"
	Playername.Position = UDim2.fromOffset(58, 15)
	Playername.Size = UDim2.fromOffset(110, 20)
	Playername.Font = Enum.Font.Code
	Playername.Text = LocalPlayer and LocalPlayer.DisplayName or "PlayerName"
	Playername.TextColor3 = Color3.fromRGB(255, 255, 255)
	Playername.TextSize = 14
	Playername.TextXAlignment = Enum.TextXAlignment.Left
	Playername.BackgroundTransparency = 1
	Playername.Parent = ProfileCard

	local Username = Instance.new("TextLabel")
	Username.Name = "Username"
	Username.Position = UDim2.fromOffset(58, 33)
	Username.Size = UDim2.fromOffset(110, 15)
	Username.Font = Enum.Font.Code
	Username.Text = "@" .. (LocalPlayer and LocalPlayer.Name or "username")
	Username.TextColor3 = Color3.fromRGB(150, 150, 150)
	Username.TextSize = 10
	Username.TextXAlignment = Enum.TextXAlignment.Left
	Username.BackgroundTransparency = 1
	Username.Parent = ProfileCard

	-- Tab Buttons Holder
	local TabList = Instance.new("UIListLayout")
	TabList.Padding = UDim.new(0, 5)
	TabList.SortOrder = Enum.SortOrder.LayoutOrder

	local TabContainer = Instance.new("Frame")
	TabContainer.Name = "TabContainer"
	TabContainer.Position = UDim2.fromOffset(0, 95)
	TabContainer.Size = UDim2.new(1, 0, 1, -95)
	TabContainer.BackgroundTransparency = 1
	TabContainer.Parent = Sidebar
	TabList.Parent = TabContainer

	-- Content Area Container
	local ContentArea = Instance.new("Frame")
	ContentArea.Name = "ContentArea"
	ContentArea.Position = UDim2.fromOffset(180, 48)
	ContentArea.Size = UDim2.new(1, -180, 1, -73)
	ContentArea.BackgroundTransparency = 1
	ContentArea.Parent = MainFrame

	-- Footnote Bar
	local Footnote = Instance.new("TextLabel")
	Footnote.Name = "Footnote"
	Footnote.Position = UDim2.new(0, 0, 1, -25)
	Footnote.Size = UDim2.new(1, 0, 0, 25)
	Footnote.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Footnote.Font = Enum.Font.Code
	Footnote.Text = Config.Footnote or "By Alpha"
	Footnote.TextColor3 = Color3.fromRGB(200, 200, 200)
	Footnote.TextSize = 12
	Footnote.TextTransparency = 0.5
	Footnote.Parent = MainFrame

	local Minimizer = Instance.new("ImageLabel")
	Minimizer.Name = "Minimizer"
	Minimizer.Position = UDim2.new(1, -20, 0, 5)
	Minimizer.Size = UDim2.fromOffset(16, 14)
	Minimizer.BackgroundTransparency = 1
	Minimizer.Image = GetLucideIcon("chevron-down")
	Minimizer.Parent = Footnote

	-- Frame Dragging Mechanism
	local dragging = false
	local dragInput, dragStart, startPos

	HeaderFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = MainFrame.Position
		end
	end)

	HeaderFrame.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			MainFrame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)

	local Window = {}

	-- Add Tab Method
	function Window:AddTab(Name: string, IconName: string?)
		local TabButton = Instance.new("TextButton")
		TabButton.Size = UDim2.new(1, -10, 0, 35)
		TabButton.Position = UDim2.fromOffset(5, 0)
		TabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
		TabButton.BackgroundTransparency = 0.5
		TabButton.Font = Enum.Font.Code
		TabButton.Text = "      " .. Name
		TabButton.TextColor3 = Color3.fromRGB(240, 240, 240)
		TabButton.TextSize = 13
		TabButton.TextXAlignment = Enum.TextXAlignment.Left
		TabButton.Parent = TabContainer

		local TabCorner = Instance.new("UICorner")
		TabCorner.CornerRadius = UDim.new(0, 4)
		TabCorner.Parent = TabButton

		if IconName then
			local IconLabel = Instance.new("ImageLabel")
			IconLabel.Size = UDim2.fromOffset(18, 18)
			IconLabel.Position = UDim2.fromOffset(8, 8)
			IconLabel.BackgroundTransparency = 1
			IconLabel.Image = GetLucideIcon(IconName)
			IconLabel.Parent = TabButton
		end

		return TabButton
	end

	return Window
end

return AWolf
