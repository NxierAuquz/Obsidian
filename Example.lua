
local httpui = "https://raw.githubusercontent.com/NxierAuquz/Obsidian/refs/heads/main/"
local Library = loadstring(game:HttpGet(httpui .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(httpui .. "ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(httpui .. "SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

local Window = Library:CreateWindow({
	Title = "Test",
	Footer = "by izenxu",
	Icon = 95816097006870,
	NotifySide = "Right",
	ShowCustomCursor = false,
})

local Tabs = {
	Main = Window:AddTab("Feature", "user"),
	Configuration = Window:AddTab("Configuration", "settings"),
}

local LeftGroupBox = Tabs.Main:AddLeftGroupbox("Groupbox")

LeftGroupBox:AddCheckbox("MyCheckbox", {
	Text = "This is a checkbox",
	Default = true,
	Disabled = false,
	Visible = true,
	Risky = false,

	Callback = function(Value)
		print("[gay] MyCheckbox changed to:", Value)
	end,
})

local MyButton = LeftGroupBox:AddButton({
	Text = "Button",
	DoubleClick = false,
	Disabled = false,
	Visible = true,
	Risky = false,

	Func = function()
		print("You clicked a button!")
	end,
})

local DropdownGroupBox = Tabs.Main:AddRightGroupbox("Dropdowns")

DropdownGroupBox:AddDropdown("MyDropdown", {
	Values = { "This", "is", "a", "dropdown" },
	Default = 1,
	Multi = false,
	Text = "A dropdown",
	Searchable = false,
	Disabled = false,
	Visible = true,

	Callback = function(Value)
		print("[cb] Dropdown got changed. New value:", Value)
	end,
})

Options.MyDropdown:OnChanged(function()
	print("Dropdown got changed. New value:", Options.MyDropdown.Value)
end)


DropdownGroupBox:AddDropdown("MyMultiDropdown", {
	Values = { "This", "is", "a", "dropdown" },
	Default = 1,
	Multi = true,
	Text = "A multi dropdown",

	Callback = function(Value)
		print("[cb] Multi dropdown got changed:")
		for key, value in next, Options.MyMultiDropdown.Value do
			print(key, value)
		end
	end,
})






--// UI Settings
Library:OnUnload(function() end)

local MenuGroup = Tabs.Configuration:AddLeftGroupbox("Menu")

MenuGroup:AddToggle("KeybindMenuOpen", {
	Default = Library.KeybindFrame.Visible,
	Text = "Open Keybind Menu",
	Callback = function(value)
		Library.KeybindFrame.Visible = value
	end,
})
MenuGroup:AddDropdown("NotificationSide", {
	Values = { "Left", "Right" },
	Default = "Right",

	Text = "Notification Side",

	Callback = function(Value)
		Library:SetNotifySide(Value)
	end,
})
MenuGroup:AddDropdown("DPIDropdown", {
	Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
	Default = "100%",

	Text = "DPI Scale",

	Callback = function(Value)
		Value = Value:gsub("%%", "")
		local DPI = tonumber(Value)

		Library:SetDPIScale(DPI)
	end,
})
MenuGroup:AddDivider()
MenuGroup:AddLabel("Menu bind")
	:AddKeyPicker("MenuKeybind", { Default = "RightControl", NoUI = true, Text = "Menu keybind" })

MenuGroup:AddButton("Unload", function()
	Library:Unload()
end)

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes({ "MenuKeybind" })

ThemeManager:SetFolder("izenxu")
SaveManager:SetFolder("izenxu/game")
SaveManager:SetSubFolder("place")

SaveManager:BuildConfigSection(Tabs.Configuration)

ThemeManager:ApplyToTab(Tabs.Configuration)

SaveManager:LoadAutoloadConfig()
