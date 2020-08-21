#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Initialize variables
DragStart := false
DragEnd := false
IncrementMode := false
Increment := 20
CoordMode, Mouse, Screen
SysGet, VirtualWidth, 78
SysGet, VirtualHeight, 79
vGuiXLoc := VirtualWidth - 100
vGuiYLoc := VirtualHeight - 80
KeyLeftArrow = j
KeyRightArrow = l
KeyUpArrow = i
KeyDownArrow = k

KeyDecrement = m
KeyIncrement = n

KeyLeftClick = u
KeyRightClick = o

KeyLeftClickBreak = f
KeyRightClickBreak = d

KeyScrollDown := ";"
KeyScrollUp = '
KeyScrollRight := ":"
KeyScrollLeft = `"

KeyPageBack = e
KeyPageForward = r

KeyCenterMouse = a
KeySwitchMode = s

KeyDragClick = h

+!m::
; Create small icon on the bottom right of the screen when mouse is running
Gui, MouseGui:Font, cBlue s32 bold, Arial 
Gui, MouseGui:Add, Text,, M
Gui, MouseGui:Color, FFFFFF
Gui, MouseGui:+LastFound +AlwaysOnTop -Caption +ToolWindow
WinSet, TransColor, FFFFFF 150
Gui, MouseGui:Show, y%vGuiYLoc% x%vGuiXLoc% NoActivate

Loop {	
	; Move mouse to center of "screen"
	MouseMove, CenterX, CenterY, 0

	; Receive user input and check for input errors
	Input, UserInput, L1 T600, {Esc} {Enter}, %KeyLeftArrow%,%KeyRightArrow%,%KeyUpArrow%,%KeyDownArrow%,%KeyDecrement%,%KeyIncrement%,%KeyLeftClick%,%KeyRightClick%,%KeyLeftClickBreak%,%KeyRightClickBreak%,%KeyScrollDown%,%KeyScrollUp%,%KeyScrollRight%,%KeyScrollLeft%,%KeyPageBack%,%KeyPageForward%,%KeyCenterMouse%,%KeySwitchMode%,%KeyDragClick%
	; QUERTY j,k,l,i,u,o,h,;,',a,s,d,f,n,m,e,r,:,"

	if (ErrorLevel = "Max")
	{
		MsgBox, You entered "%UserInput%", which is not a valid input.
		break
	}
	if (ErrorLevel = "Timeout")
	{
		MsgBox, Input has timed out.
		break
	}
	if InStr(ErrorLevel, "EndKey:")
	{
		break
	}
	
	; If no input errors, move the mouse coordinates depending on the movement mode
	if(IncrementMode)
	{
		if (UserInput = KeyLeftArrow )
		{
			CenterX := CenterX - Increment
		}
		if (UserInput = KeyRightArrow)
		{
			CenterX := CenterX + Increment
		}
		if (UserInput = KeyUpArrow)
		{
			CenterY := CenterY - Increment
		}
		if (UserInput = KeyDownArrow)
		{
			CenterY := CenterY + Increment
		}
		if (UserInput = KeyDecrement)
		{
			Increment := Increment/2
		}
		if (UserInput = KeyIncrement)
		{
			Increment := Increment * 2
		}
	}
	else
	{	
		if (UserInput = KeyLeftArrow)
		{
			EdgeRightX := CenterX
			CenterX:= (CenterX + EdgeLeftX)/2
		}
		if (UserInput = KeyRightArrow)
		{
			EdgeLeftX := CenterX
			CenterX:= (CenterX + EdgeRightX)/2
		}
		if (UserInput = KeyUpArrow)
		{
			EdgeBottomY := CenterY
			CenterY := (CenterY + EdgeTopY)/2
		}
		if (UserInput = KeyDownArrow)
		{
			EdgeTopY := CenterY
			CenterY := (CenterY + EdgeBottomY)/2
		}

	}

	; Clicks with the right hand keys do not break out of the loop
	if (UserInput = KeyLeftClick)
	{
		Click
	}
	if (UserInput = KeyRightClick)
	{
		Click, Right
	}

	; Clicks with the left hand keys break out of the loop
	if (UserInput = KeyLeftClickBreak )
	{
		Click
		break
	}	
	if (UserInput = KeyRightClickBreak)
	{
		Click, Right
		break
	}

	; Scroll the wheel up, down, right, and left, respectively
	if (UserInput = KeyScrollDown)
	{
		Click, WheelDown
	}
	if (UserInput = KeyScrollUp)
	{
		Click, WheelUp
	}
	if (UserInput = KeyScrollRight)
	{
		ControlGetFocus, fcontrol, A
		SendMessage, 0x114, 1, 0, %fcontrol%, A  
	}
	if (UserInput = KeyScrollLeft)
	{
		ControlGetFocus, fcontrol, A
		SendMessage, 0x114, 0, 0, %fcontrol%, A  
	}
	
	; Page back, page forward
	if (UserInput = KeyPageBack)
	{
		Click, X1
	}
	if (UserInput = KeyPageForward)
	{
		Click, X2
	}

	; Center the mouse and switch to BinarySearch mode. Reset Increment amount.
	if (UserInput = KeyCenterMouse)
	{
		EdgeLeftX := 0
		EdgeRightX := VirtualWidth
		EdgeTopY := 0
		EdgeBottomY := VirtualHeight
		CenterX := EdgeRightX/2
		CenterY := EdgeBottomY/2
		Increment := 20
		IncrementMode := false
	}
	
	; Switch movement modes
	if (UserInput = KeySwitchMode)
	{
		IncrementMode := !IncrementMode
	}
	
	; Click and drag functionality
	if (UserInput = KeyDragClick)
	{
		if (!DragStart)
		{
			DragStartX := CenterX
			DragStartY := CenterY
			DragStart := true
		}
		else
		{
			DragEnd := true
		}
		
		if (DragStart && DragEnd)
		{
			SendMode Event
			MouseClickDrag, Left, DragStartX, DragStartY, CenterX, CenterY, 4
			SendMode Input
			DragStart := false
			DragEnd := false
		}
	}
}

; Remove icon when mouse is not active 
Gui, MouseGui:Destroy
return
