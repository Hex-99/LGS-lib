--[[ Configuration --]]
SCREEN_WIDTH = 2560		--[[ Change according to your screen resolution --]]
SCREEN_HEIGHT = 1440	--[[ eg. the default value stands for 2K resolution --]]
DELAY = 200				--[[ Auto delay between each key press or mouse click in milliseconds--]]

--[[ State variable --]]
DEBUG_MODE = false		--[[ In debug mode, each key press or mouse click is printed --]]

function OnEvent(event, arg)

	--[[ User-defined buttons --]]
	if (event == "G_RELEASED" and arg == 1) then
		
	end
	
	if (event == "G_RELEASED" and arg == 2) then
		
	end
	
	if (event == "G_RELEASED" and arg == 3) then
		
	end
	
	if (event == "G_RELEASED" and arg == 4) then
		
	end
	
	if (event == "G_RELEASED" and arg == 5) then
		
	end
	
	--[[ Print mouse state --]]
	if (event == "G_RELEASED" and arg == 6) then
		PrintMouseState()
	end
	
	--[[ Toggle debug mode --]]
	if (event == "G_RELEASED" and arg == 7) then
		DEBUG_MODE = not DEBUG_MODE
		if (DEBUG_MODE) then
			Print("Debug mode: On")
		else
			Print("Debug mode: Off")
		end
	end
	
	--[[ Record mouse action --]]
	if (event == "G_RELEASED" and arg == 8) then
		x, y = GetPos()
		Print("MoveToAndLeftClick(%d, %d)", x, y)
	end
	
	if (event == "G_RELEASED" and arg == 9) then
		x, y = GetPos()
		Print("MoveToAndRightClick(%d, %d)", x, y)
	end
end

--[[ User-made macros --]]

function example()
	MoveToAndLeftClick(2265, 1412)
	MoveToAndRightClick(2259, 1361)
	KeyPress("up", 3)
	KeyPress("enter")
	MoveToAndLeftClick(1141, 841)
	MoveToAndLeftClick(1454, 842)
end

--[[ Mouse library --]]

function GetPos()
	x, y = GetMousePosition()
	x = x / 65535 * SCREEN_WIDTH
	y = y / 65535 * SCREEN_HEIGHT
	return x, y
end

function MoveTo(x, y)
	if (DEBUG_MODE) then
		Print("MoveTo(%d, %d)", x, y)
	end
	
	x = x / SCREEN_WIDTH * 65535
	y = y / SCREEN_HEIGHT * 65535
	MoveMouseTo(x, y)
	
	Sleep(DELAY)
end

function LeftClick()
	if (DEBUG_MODE) then
		Print("LeftClick()")
	end
	
	PressAndReleaseMouseButton(1)
		
	Sleep(DELAY)
end

function RightClick()
	if (DEBUG_MODE) then
		Print("RightClick()")
	end
	
	PressAndReleaseMouseButton(3)
		
	Sleep(DELAY)
end

function MoveToAndLeftClick(x, y)
	MoveTo(x, y)
	LeftClick()
end

function MoveToAndRightClick(x, y)
	MoveTo(x, y)
	RightClick()
end

--[[ Keyboard library --]]

function KeyPress(keyname, count)
	if (count == nil) then
		count = 1
	end
	
	for i = 1, count, 1 do
		if (DEBUG_MODE) then
			Print("KeyPress(\"%s\")", keyname)
		end
	
		PressAndReleaseKey(keyname)
			
		Sleep(DELAY)
	end
end

function KeyPressModified(keyname1, keyname2, count)
	if (count == nil) then
		count = 1
	end
	
	for i = 1, count, 1 do
		if (DEBUG_MODE) then
			Print("KeyPressModified(\"%s\", \"%s\")", keyname1, keyname2)
		end
	
		PressKey(keyname1)
		Sleep(DELAY / 4)
		PressKey(keyname2)
		Sleep(DELAY / 4)
		ReleaseKey(keyname2)
		Sleep(DELAY / 4)
		ReleaseKey(keyname1)
		
		Sleep(DELAY)
	end
end

--[[ Other library --]]

function Print(...)
	OutputLogMessage(...)
	OutputLogMessage("\n")
end

function PrintMouseState()
	EnablePrimaryMouseButtonEvents(true)

	Print("------------------------------------------")
	if (IsMouseButtonPressed(1)) then
		Print("Left Mouse Button: Pressed")
	else
		Print("Left Mouse Button: Not Pressed")
	end
	if (IsMouseButtonPressed(2)) then
		Print("Middle Mouse Button: Pressed")
	else
		Print("Middle Mouse Button: Not Pressed")
	end
	if (IsMouseButtonPressed(3)) then
		Print("Right Mouse Button: Pressed")
	else
		Print("Right Mouse Button: Not Pressed")
	end
	Print("------------------------------------------")
end