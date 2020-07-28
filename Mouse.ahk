#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

+!m::
; Initialize variables
DragStart := false
DragEnd := false
IncrementMode := false
Increment := 20
CoordMode, Mouse, Screen
SysGet, VirtualWidth, 78
SysGet, VirtualHeight, 79


Loop {	
	; Move mouse to center of "screen"
	MouseMove, CenterX, CenterY, 0

	; Receive user "arrow keys" and check for input errors
	Input, UserInput, L1 T600, {Esc} {Enter}, j,k,l,i,u,o,h,;,',a,s,d,f,n,m,e,r,:,"
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
		if (UserInput = "j")
		{
			CenterX := CenterX - Increment
		}
		if (UserInput = "l")
		{
			CenterX := CenterX + Increment
		}
		if (UserInput = "i")
		{
			CenterY := CenterY - Increment
		}
		if (UserInput = "k")
		{
			CenterY := CenterY + Increment
		}
		if (UserInput = "m")
		{
			Increment := Increment/2
		}
		if (UserInput = "n")
		{
			Increment := Increment * 2
		}
	}
	else
	{	
		if (UserInput = "j")
		{
			EdgeRightX := CenterX
			CenterX:= (CenterX + EdgeLeftX)/2
		}
		if (UserInput = "l")
		{
			EdgeLeftX := CenterX
			CenterX:= (CenterX + EdgeRightX)/2
		}
		if (UserInput = "i")
		{
			EdgeBottomY := CenterY
			CenterY := (CenterY + EdgeTopY)/2
		}
		if (UserInput = "k")
		{
			EdgeTopY := CenterY
			CenterY := (CenterY + EdgeBottomY)/2
		}

	}

	; Clicks with the right hand keys do not break out of the loop
	if (UserInput = "u")
	{
		Click
	}
	if (UserInput = "o")
	{
		Click, Right
	}

	; Clicks with the left hand keys do break out of the loop
	if (UserInput = "f")
	{
		Click
		break
	}	
	if (UserInput = "d")
	{
		Click, Right
		break
	}

	; Scroll the wheel up, down, right, and left, respectively
	if (UserInput = ";")
	{
		Click, WheelDown
	}
	if (UserInput = "'")
	{
		Click, WheelUp
	}
	if (UserInput = ":")
	{
		ControlGetFocus, fcontrol, A
		SendMessage, 0x114, 1, 0, %fcontrol%, A  
	}
	if UserInput = "
	{
		ControlGetFocus, fcontrol, A
		SendMessage, 0x114, 0, 0, %fcontrol%, A  
	}
	
	; Page back, page forward
	if (UserInput = "e")
	{
		Click, X1
	}
	if (UserInput = "r")
	{
		Click, X2
	}

	; Center the mouse and switch to BinarySearch mode. Reset Increment amount.
	if (UserInput = "a")
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
	if (UserInput = "s")
	{
		IncrementMode := !IncrementMode
	}
	
	; Click and drag functionality
	if (UserInput = "h")
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
return
