# AHK_Mouse
Control mouse movement with keyboard

There are two modes of movement: Increment and BinarySearch. Increment is the standard method of moving a mouse where a direction key is pressed and then the cursor moves a certain number of pixels in that direction. BinarySearch starts the cursor in the center of the screen. The screen can be conceptually subdivided into 4 "halves" (top half, bottom half, right half, left half). When a direction key is pressed, the mouse jumps to the center of the selected half which becomes the new "screen" and then subdivides that "screen" into 4 "halves" again. This can be repeated until the available "screen" becomes small enough where the screen center(the cursor) is over the target location.

Script Flow Controls:
Alt + Shift + M: Start script
Esc: End script without error message
Enter: End script without error message
Any unbound keys: Exit with error message
Timout: Exit with error message, default timeout set to 10 minutes

Cursor movement:
j: Left
l: Right
i: Up
k: Down

Click:
u: Left click and continue using script
o: Right click and continue using script
f: Left click and exit script without error message
d: Right click and exit script without error message
