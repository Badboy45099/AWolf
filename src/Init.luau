--!strict
-- AWolf UI Library Framework (Obsidian / Fluent / Rayfield Hybrid)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

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

-- Notification System
function AWolf:Notify(Config: { Title: string, Content: string, Duration: number? })
	local NotificationHolder = CoreGui:FindFirstChild("AWolfNotificationHolder")
	if not NotificationHolder then
		NotificationHolder = Instance.new("ScreenGui")
		NotificationHolder.Name = "AWolfNotificationHolder"
		NotificationHolder.Parent = CoreGui
		
		local Container = Instance.new("Frame")
		Container.Name = "Container"
		Container.Position = UDim2.new(1, -280, 1, -30)
		Container.Size = UDim2.new(0, 260, 1, 0)
		Container.AnchorPoint = Vector2.new(0, 1)
		Container.BackgroundTransparency = 1
		Container.Parent = NotificationHolder
		
		local ListLayout = Instance.new("UIListLayout")
		ListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
		ListLayout.Padding = UDim.new(0, 8)
		ListLayout.Parent = Container
	end

	local Container = NotificationHolder:FindFirstChild("Container") :: Frame

	local Toast = Instance.new("Frame")
	Toast.Size = UDim2.new(1, 0, 0, 60)
	Toast.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
	Toast.BorderSizePixel = 0
	Toast.BackgroundTransparency = 1
	Toast.Parent = Container

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 6)
	Corner.Parent = Toast

	local Stroke = Instance.new("UIStroke")
	Stroke.Color = Color3.fromRGB(130, 6, 6)
	Stroke.Thickness = 1
	Stroke.Transparency = 1
	Stroke.Parent = Toast

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Size = UDim2.new(1, -15, 0, 20)
	TitleLabel.Position = UDim2.fromOffset(10, 8)
	TitleLabel.Font = Enum.Font.Code
	TitleLabel.Text = Config.Title or "Notification"
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.TextSize = 13
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.TextTransparency = 1
	TitleLabel.Parent = Toast

	local ContentLabel = Instance.new("TextLabel")
	ContentLabel.Size = UDim2.new(1, -15, 0, 25)
	ContentLabel.Position = UDim2.fromOffset(10, 26)
	ContentLabel.Font = Enum.Font.Code
	ContentLabel.Text = Config.Content or ""
	ContentLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
	ContentLabel.TextSize = 11
	ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
	ContentLabel.TextWrapped = true
	ContentLabel.BackgroundTransparency = 1
	ContentLabel.TextTransparency = 1
	ContentLabel.Parent = Toast

	-- Fade In
	TweenService:Create(Toast, TweenInfo.new(0.3), { BackgroundTransparency = 0.1 }):Play()
	TweenService:Create(Stroke, TweenInfo.new(0.3), { Transparency = 0 }):Play()
	TweenService:Create(TitleLabel, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()
	TweenService:Create(ContentLabel, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()

	task.delay(Config.Duration or 3, function()
		local FadeOut = TweenService:Create(Toast, TweenInfo.new(0.3), { BackgroundTransparency = 1 })
		TweenService:Create(Stroke, TweenInfo.new(0.3), { Transparency = 1 }):Play()
		TweenService:Create(TitleLabel, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
		TweenService:Create(ContentLabel, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
		FadeOut:Play()
		FadeOut.Completed:Connect(function()
			Toast:Destroy()
		end)
	end)
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
	MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
	MainFrame.BackgroundTransparency = 0.15
	MainFrame.BorderSizePixel = 0
	MainFrame.Position = UDim2.fromScale(0.5, 0.5)
	MainFrame.Size = UDim2.fromOffset(680, 420)
	MainFrame.ClipsDescendants = true
	MainFrame.Parent = WolfUI

	local MainCorner = Instance.new("UICorner")
	MainCorner.CornerRadius = UDim.new(0, 8)
	MainCorner.Parent = MainFrame

	local MainStroke = Instance.new("UIStroke")
	MainStroke.Color = Color3.fromRGB(130, 6, 6)
	MainStroke.Thickness = 1.2
	MainStroke.Parent = MainFrame

	-- Top Header Bar
	local HeaderFrame = Instance.new("Frame")
	HeaderFrame.Name = "HeaderFrame"
	HeaderFrame.Size = UDim2.new(1, 0, 0, 48)
	HeaderFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
	HeaderFrame.BackgroundTransparency = 0.3
	HeaderFrame.BorderSizePixel = 0
	HeaderFrame.Parent = MainFrame

	local HeaderTitle = Instance.new("TextLabel")
	HeaderTitle.Name = "HeaderTitle"
	HeaderTitle.Position = UDim2.fromOffset(190, 0)
	HeaderTitle.Size = UDim2.fromOffset(180, 48)
	HeaderTitle.FontFace = Font.fromName("Bangers", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	HeaderTitle.Text = Config.Title or "WolfTool"
	HeaderTitle.TextColor3 = Color3.fromRGB(180, 15, 15)
	HeaderTitle.TextSize = 26
	HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
	HeaderTitle.BackgroundTransparency = 1
	HeaderTitle.Parent = HeaderFrame

	local SearchBox = Instance.new("TextBox")
	SearchBox.Name = "SearchBox"
	SearchBox.Position = UDim2.fromOffset(410, 8)
	SearchBox.Size = UDim2.fromOffset(125, 32)
	SearchBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	SearchBox.Font = Enum.Font.Code
	SearchBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
	SearchBox.PlaceholderText = "🔍 Search..."
	SearchBox.Text = ""
	SearchBox.TextColor3 = Color3.fromRGB(240, 240, 240)
	SearchBox.TextSize = 12
	SearchBox.Parent = HeaderFrame

	local SearchCorner = Instance.new("UICorner")
	SearchCorner.CornerRadius = UDim.new(0, 6)
	SearchCorner.Parent = SearchBox

	local LockButton = Instance.new("TextButton")
	LockButton.Name = "LockButton"
	LockButton.Position = UDim2.fromOffset(545, 11)
	LockButton.Size = UDim2.fromOffset(65, 26)
	LockButton.BackgroundColor3 = Color3.fromRGB(130, 6, 6)
	LockButton.FontFace = Font.fromName("Code", Enum.FontWeight.Bold, Enum.FontStyle.Italic)
	LockButton.Text = "LOCK"
	LockButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	LockButton.TextSize = 12
	LockButton.Parent = HeaderFrame

	local LockCorner = Instance.new("UICorner")
	LockCorner.CornerRadius = UDim.new(0, 5)
	LockCorner.Parent = LockButton

	local DragIcon = Instance.new("ImageLabel")
	DragIcon.Name = "DragIcon"
	DragIcon.Position = UDim2.fromOffset(628, 6)
	DragIcon.Size = UDim2.fromOffset(36, 36)
	DragIcon.BackgroundTransparency = 1
	DragIcon.Image = GetLucideIcon("move")
	DragIcon.ImageColor3 = Color3.fromRGB(180, 15, 15)
	DragIcon.Parent = HeaderFrame

	-- Left Sidebar
	local Sidebar = Instance.new("Frame")
	Sidebar.Name = "Sidebar"
	Sidebar.Position = UDim2.fromOffset(0, 0)
	Sidebar.Size = UDim2.new(0, 180, 1, -25)
	Sidebar.BackgroundColor3 = Color3.fromRGB(14, 14, 16)
	Sidebar.BackgroundTransparency = 0.2
	Sidebar.BorderSizePixel = 0
	Sidebar.Parent = MainFrame

	-- Profile Card
	local ProfileCard = Instance.new("Frame")
	ProfileCard.Name = "ProfileCard"
	ProfileCard.Size = UDim2.new(1, 0, 0, 90)
	ProfileCard.BackgroundColor3 = Color3.fromRGB(22, 22, 25)
	ProfileCard.BorderSizePixel = 0
	ProfileCard.Parent = Sidebar

	local Avatar = Instance.new("ImageLabel")
	Avatar.Name = "Avatar"
	Avatar.Position = UDim2.fromOffset(10, 15)
	Avatar.Size = UDim2.fromOffset(40, 40)
	Avatar.BackgroundTransparency = 1
	Avatar.Image = GetLucideIcon("user")
	Avatar.ImageColor3 = Color3.fromRGB(220, 220, 220)
	Avatar.Parent = ProfileCard

	local Playername = Instance.new("TextLabel")
	Playername.Name = "Playername"
	Playername.Position = UDim2.fromOffset(58, 15)
	Playername.Size = UDim2.fromOffset(110, 20)
	Playername.Font = Enum.Font.Code
	Playername.Text = LocalPlayer and LocalPlayer.DisplayName or "PlayerName"
	Playername.TextColor3 = Color3.fromRGB(255, 255, 255)
	Playername.TextSize = 13
	Playername.TextXAlignment = Enum.TextXAlignment.Left
	Playername.BackgroundTransparency = 1
	Playername.Parent = ProfileCard

	local Username = Instance.new("TextLabel")
	Username.Name = "Username"
	Username.Position = UDim2.fromOffset(58, 33)
	Username.Size = UDim2.fromOffset(110, 15)
	Username.Font = Enum.Font.Code
	Username.Text = "@" .. (LocalPlayer and LocalPlayer.Name or "username")
	Username.TextColor3 = Color3.fromRGB(140, 140, 140)
	Username.TextSize = 10
	Username.TextXAlignment = Enum.TextXAlignment.Left
	Username.BackgroundTransparency = 1
	Username.Parent = ProfileCard

	local SubtextLabel = Instance.new("TextLabel")
	SubtextLabel.Name = "Subtext"
	SubtextLabel.Position = UDim2.fromOffset(58, 48)
	SubtextLabel.Size = UDim2.fromOffset(110, 15)
	SubtextLabel.Font = Enum.Font.Code
	SubtextLabel.Text = "SUBTEXT"
	SubtextLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
	SubtextLabel.TextSize = 9
	SubtextLabel.TextXAlignment = Enum.TextXAlignment.Left
	SubtextLabel.BackgroundTransparency = 1
	SubtextLabel.Parent = ProfileCard

	-- Tab Buttons Container
	local TabContainer = Instance.new("ScrollingFrame")
	TabContainer.Name = "TabContainer"
	TabContainer.Position = UDim2.fromOffset(0, 95)
	TabContainer.Size = UDim2.new(1, 0, 1, -95)
	TabContainer.BackgroundTransparency = 1
	TabContainer.ScrollBarThickness = 2
	TabContainer.Parent = Sidebar

	local TabList = Instance.new("UIListLayout")
	TabList.Padding = UDim.new(0, 4)
	TabList.SortOrder = Enum.SortOrder.LayoutOrder
	TabList.Parent = TabContainer

	-- Content Container
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
	Footnote.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
	Footnote.Font = Enum.Font.Code
	Footnote.Text = Config.Footnote or "By Alpha"
	Footnote.TextColor3 = Color3.fromRGB(180, 180, 180)
	Footnote.TextSize = 11
	Footnote.TextTransparency = 0.4
	Footnote.Parent = MainFrame

	local Minimizer = Instance.new("ImageLabel")
	Minimizer.Name = "Minimizer"
	Minimizer.Position = UDim2.new(1, -22, 0, 5)
	Minimizer.Size = UDim2.fromOffset(16, 14)
	Minimizer.BackgroundTransparency = 1
	Minimizer.Image = GetLucideIcon("chevron-down")
	Minimizer.ImageColor3 = Color3.fromRGB(180, 180, 180)
	Minimizer.Parent = Footnote

	-- Dragging Logic
	local dragging = false
	local isLocked = false
	local dragInput, dragStart, startPos

	LockButton.MouseButton1Click:Connect(function()
		isLocked = not isLocked
		LockButton.Text = isLocked and "LOCKED" or "LOCK"
		LockButton.BackgroundColor3 = isLocked and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(130, 6, 6)
	end)

	HeaderFrame.InputBegan:Connect(function(input)
		if not isLocked and input.UserInputType == Enum.UserInputType.MouseButton1 then
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

	-- Minimalizer / Collapse Logic
	local isMinimized = false
	Minimizer.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			isMinimized = not isMinimized
			TweenService:Create(MainFrame, TweenInfo.new(0.3), {
				Size = isMinimized and UDim2.fromOffset(680, 48) or UDim2.fromOffset(680, 420)
			}):Play()
		end
	end)

	local Window = {
		Tabs = {},
		ActiveTab = nil,
	}

	-- Add Tab Method
	function Window:AddTab(Name: string, IconName: string?)
		local TabButton = Instance.new("TextButton")
		TabButton.Size = UDim2.new(1, -10, 0, 36)
		TabButton.Position = UDim2.fromOffset(5, 0)
		TabButton.BackgroundColor3 = Color3.fromRGB(28, 28, 30)
		TabButton.BackgroundTransparency = 0.5
		TabButton.Font = Enum.Font.Code
		TabButton.Text = "       " .. Name
		TabButton.TextColor3 = Color3.fromRGB(180, 180, 180)
		TabButton.TextSize = 13
		TabButton.TextXAlignment = Enum.TextXAlignment.Left
		TabButton.Parent = TabContainer

		local TabCorner = Instance.new("UICorner")
		TabCorner.CornerRadius = UDim.new(0, 5)
		TabCorner.Parent = TabButton

		if IconName then
			local IconLabel = Instance.new("ImageLabel")
			IconLabel.Size = UDim2.fromOffset(18, 18)
			IconLabel.Position = UDim2.fromOffset(8, 9)
			IconLabel.BackgroundTransparency = 1
			IconLabel.Image = GetLucideIcon(IconName)
			IconLabel.ImageColor3 = Color3.fromRGB(180, 180, 180)
			IconLabel.Parent = TabButton
		end

		-- Page Frame
		local Page = Instance.new("ScrollingFrame")
		Page.Name = Name .. "Page"
		Page.Size = UDim2.new(1, 0, 1, 0)
		Page.BackgroundTransparency = 1
		Page.Visible = false
		Page.ScrollBarThickness = 3
		Page.Parent = ContentArea

		local PageLayout = Instance.new("UIListLayout")
		PageLayout.Padding = UDim.new(0, 8)
		PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
		PageLayout.Parent = Page

		local PagePadding = Instance.new("UIPadding")
		PagePadding.PaddingTop = UDim.new(0, 10)
		PagePadding.PaddingLeft = UDim.new(0, 10)
		PagePadding.PaddingRight = UDim.new(0, 10)
		PagePadding.Parent = Page

		-- Selection Behavior
		TabButton.MouseButton1Click:Connect(function()
			for _, tab in ipairs(Window.Tabs) do
				tab.Button.BackgroundColor3 = Color3.fromRGB(28, 28, 30)
				tab.Button.TextColor3 = Color3.fromRGB(180, 180, 180)
				tab.Page.Visible = false
			end
			TabButton.BackgroundColor3 = Color3.fromRGB(130, 6, 6)
			TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			Page.Visible = true
			Window.ActiveTab = Page
		end)

		if #Window.Tabs == 0 then
			TabButton.BackgroundColor3 = Color3.fromRGB(130, 6, 6)
			TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			Page.Visible = true
			Window.ActiveTab = Page
		end

		local TabElements = {}
		table.insert(Window.Tabs, { Button = TabButton, Page = Page })

		-- Add Button Element
		function TabElements:AddButton(Config: { Name: string, Callback: () -> () })
			local Btn = Instance.new("TextButton")
			Btn.Size = UDim2.new(1, 0, 0, 36)
			Btn.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
			Btn.Font = Enum.Font.Code
			Btn.Text = "  " .. Config.Name
			Btn.TextColor3 = Color3.fromRGB(240, 240, 240)
			Btn.TextSize = 13
			Btn.TextXAlignment = Enum.TextXAlignment.Left
			Btn.Parent = Page

			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 6)
			Corner.Parent = Btn

			local Icon = Instance.new("ImageLabel")
			Icon.Size = UDim2.fromOffset(16, 16)
			Icon.Position = UDim2.new(1, -26, 0.5, -8)
			Icon.BackgroundTransparency = 1
			Icon.Image = GetLucideIcon("chevron-right")
			Icon.ImageColor3 = Color3.fromRGB(150, 150, 150)
			Icon.Parent = Btn

			Btn.MouseButton1Click:Connect(function()
				TweenService:Create(Btn, TweenInfo.new(0.1), { BackgroundColor3 = Color3.fromRGB(130, 6, 6) }):Play()
				task.delay(0.1, function()
					TweenService:Create(Btn, TweenInfo.new(0.1), { BackgroundColor3 = Color3.fromRGB(28, 28, 32) }):Play()
				end)
				if Config.Callback then Config.Callback() end
			end)
		end

		-- Add Toggle Element
		function TabElements:AddToggle(Config: { Name: string, Default: boolean?, Callback: (boolean) -> () })
			local State = Config.Default or false

			local ToggleFrame = Instance.new("Frame")
			ToggleFrame.Size = UDim2.new(1, 0, 0, 36)
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
			ToggleFrame.Parent = Page

			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 6)
			Corner.Parent = ToggleFrame

			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(1, -60, 1, 0)
			Label.Position = UDim2.fromOffset(10, 0)
			Label.Font = Enum.Font.Code
			Label.Text = Config.Name
			Label.TextColor3 = Color3.fromRGB(240, 240, 240)
			Label.TextSize = 13
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.BackgroundTransparency = 1
			Label.Parent = ToggleFrame

			local Switch = Instance.new("Frame")
			Switch.Size = UDim2.fromOffset(40, 20)
			Switch.Position = UDim2.new(1, -50, 0.5, -10)
			Switch.BackgroundColor3 = State and Color3.fromRGB(130, 6, 6) or Color3.fromRGB(45, 45, 50)
			Switch.Parent = ToggleFrame

			local SwitchCorner = Instance.new("UICorner")
			SwitchCorner.CornerRadius = UDim.new(1, 0)
			SwitchCorner.Parent = Switch

			local Knob = Instance.new("Frame")
			Knob.Size = UDim2.fromOffset(16, 16)
			Knob.Position = State and UDim2.fromOffset(22, 2) or UDim2.fromOffset(2, 2)
			Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Knob.Parent = Switch

			local KnobCorner = Instance.new("UICorner")
			KnobCorner.CornerRadius = UDim.new(1, 0)
			KnobCorner.Parent = Knob

			local Button = Instance.new("TextButton")
			Button.Size = UDim2.new(1, 0, 1, 0)
			Button.BackgroundTransparency = 1
			Button.Text = ""
			Button.Parent = ToggleFrame

			Button.MouseButton1Click:Connect(function()
				State = not State
				TweenService:Create(Switch, TweenInfo.new(0.2), {
					BackgroundColor3 = State and Color3.fromRGB(130, 6, 6) or Color3.fromRGB(45, 45, 50)
				}):Play()
				TweenService:Create(Knob, TweenInfo.new(0.2), {
					Position = State and UDim2.fromOffset(22, 2) or UDim2.fromOffset(2, 2)
				}):Play()

				if Config.Callback then Config.Callback(State) end
			end)
		end

		-- Add Slider Element
		function TabElements:AddSlider(Config: { Name: string, Min: number, Max: number, Default: number?, Callback: (number) -> () })
			local Value = Config.Default or Config.Min

			local SliderFrame = Instance.new("Frame")
			SliderFrame.Size = UDim2.new(1, 0, 0, 48)
			SliderFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
			SliderFrame.Parent = Page

			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 6)
			Corner.Parent = SliderFrame

			local Label = Instance.new("TextLabel")
			Label.Size = UDim2.new(1, -70, 0, 24)
			Label.Position = UDim2.fromOffset(10, 2)
			Label.Font = Enum.Font.Code
			Label.Text = Config.Name
			Label.TextColor3 = Color3.fromRGB(240, 240, 240)
			Label.TextSize = 12
			Label.TextXAlignment = Enum.TextXAlignment.Left
			Label.BackgroundTransparency = 1
			Label.Parent = SliderFrame

			local ValLabel = Instance.new("TextLabel")
			ValLabel.Size = UDim2.new(0, 50, 0, 24)
			ValLabel.Position = UDim2.new(1, -60, 0, 2)
			ValLabel.Font = Enum.Font.Code
			ValLabel.Text = tostring(Value)
			ValLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
			ValLabel.TextSize = 12
			ValLabel.TextXAlignment = Enum.TextXAlignment.Right
			ValLabel.BackgroundTransparency = 1
			ValLabel.Parent = SliderFrame

			local Track = Instance.new("Frame")
			Track.Size = UDim2.new(1, -20, 0, 8)
			Track.Position = UDim2.fromOffset(10, 30)
			Track.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
			Track.Parent = SliderFrame

			local TrackCorner = Instance.new("UICorner")
			TrackCorner.CornerRadius = UDim.new(1, 0)
			TrackCorner.Parent = Track

			local Fill = Instance.new("Frame")
			Fill.Size = UDim2.new((Value - Config.Min) / (Config.Max - Config.Min), 0, 1, 0)
			Fill.BackgroundColor3 = Color3.fromRGB(130, 6, 6)
			Fill.Parent = Track

			local FillCorner = Instance.new("UICorner")
			FillCorner.CornerRadius = UDim.new(1, 0)
			FillCorner.Parent = Fill

			local Sliding = false

			local function Update(input)
				local Pos = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
				Value = math.floor(Config.Min + ((Config.Max - Config.Min) * Pos))
				ValLabel.Text = tostring(Value)
				Fill.Size = UDim2.new(Pos, 0, 1, 0)
				if Config.Callback then Config.Callback(Value) end
			end

			Track.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Sliding = true
					Update(input)
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if Sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
					Update(input)
				end
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Sliding = false
				end
			end)
		end

		-- Add Dropdown Element (Single / Multi Selectable)
		function TabElements:AddDropdown(Config: { Name: string, Options: { string }, Multi: boolean?, Callback: (any) -> () })
			local Expanded = false
			local Selected = Config.Multi and {} or Config.Options[1]

			local DropdownFrame = Instance.new("Frame")
			DropdownFrame.Size = UDim2.new(1, 0, 0, 36)
			DropdownFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
			DropdownFrame.ClipsDescendants = true
			DropdownFrame.Parent = Page

			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 6)
			Corner.Parent = DropdownFrame

			local TitleLabel = Instance.new("TextLabel")
			TitleLabel.Size = UDim2.new(1, -40, 0, 36)
			TitleLabel.Position = UDim2.fromOffset(10, 0)
			TitleLabel.Font = Enum.Font.Code
			TitleLabel.Text = Config.Name .. " (" .. (type(Selected) == "table" and table.concat(Selected, ", ") or tostring(Selected)) .. ")"
			TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
			TitleLabel.TextSize = 12
			TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
			TitleLabel.BackgroundTransparency = 1
			TitleLabel.Parent = DropdownFrame

			local Arrow = Instance.new("ImageLabel")
			Arrow.Size = UDim2.fromOffset(16, 16)
			Arrow.Position = UDim2.new(1, -26, 0, 10)
			Arrow.BackgroundTransparency = 1
			Arrow.Image = GetLucideIcon("chevron-down")
			Arrow.ImageColor3 = Color3.fromRGB(150, 150, 150)
			Arrow.Parent = DropdownFrame

			local Container = Instance.new("Frame")
			Container.Position = UDim2.fromOffset(0, 36)
			Container.Size = UDim2.new(1, 0, 0, #Config.Options * 28)
			Container.BackgroundTransparency = 1
			Container.Parent = DropdownFrame

			local List = Instance.new("UIListLayout")
			List.SortOrder = Enum.SortOrder.LayoutOrder
			List.Parent = Container

			local ToggleBtn = Instance.new("TextButton")
			ToggleBtn.Size = UDim2.new(1, 0, 0, 36)
			ToggleBtn.BackgroundTransparency = 1
			ToggleBtn.Text = ""
			ToggleBtn.Parent = DropdownFrame

			local function ToggleDropdown()
				Expanded = not Expanded
				local TargetHeight = Expanded and (36 + #Config.Options * 28) or 36
				TweenService:Create(DropdownFrame, TweenInfo.new(0.2), { Size = UDim2.new(1, 0, 0, TargetHeight) }):Play()
				TweenService:Create(Arrow, TweenInfo.new(0.2), { Rotation = Expanded and 180 or 0 }):Play()
			end

			ToggleBtn.MouseButton1Click:Connect(ToggleDropdown)

			for _, opt in ipairs(Config.Options) do
				local OptBtn = Instance.new("TextButton")
				OptBtn.Size = UDim2.new(1, 0, 0, 28)
				OptBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
				OptBtn.Font = Enum.Font.Code
				OptBtn.Text = "    " .. opt
				OptBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
				OptBtn.TextSize = 11
				OptBtn.TextXAlignment = Enum.TextXAlignment.Left
				OptBtn.Parent = Container

				OptBtn.MouseButton1Click:Connect(function()
					if Config.Multi then
						local pos = table.find(Selected :: {string}, opt)
						if pos then
							table.remove(Selected :: {string}, pos)
						else
							table.insert(Selected :: {string}, opt)
						end
						TitleLabel.Text = Config.Name .. " (" .. table.concat(Selected :: {string}, ", ") .. ")"
						if Config.Callback then Config.Callback(Selected) end
					else
						Selected = opt
						TitleLabel.Text = Config.Name .. " (" .. opt .. ")"
						ToggleDropdown()
						if Config.Callback then Config.Callback(Selected) end
					end
				end)
			end
		end

		-- Section Container
		function TabElements:AddSection(Title: string)
			local SectionFrame = Instance.new("Frame")
			SectionFrame.Size = UDim2.new(1, 0, 0, 26)
			SectionFrame.BackgroundTransparency = 1
			SectionFrame.Parent = Page

			local SectionText = Instance.new("TextLabel")
			SectionText.Size = UDim2.new(1, 0, 1, 0)
			SectionText.Font = Enum.Font.Code
			SectionText.Text = Title
			SectionText.TextColor3 = Color3.fromRGB(130, 6, 6)
			SectionText.TextSize = 13
			SectionText.TextXAlignment = Enum.TextXAlignment.Left
			SectionText.BackgroundTransparency = 1
			SectionText.Parent = SectionFrame
		end

		return TabElements
	end

	-- Live Search Filter Implementation
	SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
		local Query = SearchBox.Text:lower()
		if Window.ActiveTab then
			for _, child in ipairs(Window.ActiveTab:GetChildren()) do
				if child:IsA("Frame") or child:IsA("TextButton") then
					local Label = child:FindFirstChildOfClass("TextLabel") or (child:IsA("TextButton") and child or nil)
					if Label and Label.Text then
						if Query == "" or Label.Text:lower():find(Query, 1, true) then
							child.Visible = true
						else
							child.Visible = false
						end
					end
				end
			end
		end
	end)

	return Window
end

return AWolf
