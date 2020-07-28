# AHK_Mouse
AutoHotKey script to control mouse movement with keyboard

SUMMARY
-------
There are two modes of movement: Increment and BinarySearch. Increment is the standard method of moving a mouse where a direction key is pressed and then the cursor moves a certain number of pixels in that direction. BinarySearch starts the cursor in the center of the screen. The screen can be conceptually subdivided into 4 "halves" (top half, bottom half, right half, left half). When a direction key is pressed, the mouse jumps to the center of the selected half which becomes the new "screen" and then subdivides that "screen" into 4 "halves" again. This can be repeated until the available "screen" becomes small enough where the screen center (and therefore the cursor) is over the target.

CONTROLS
--------
Program Flow:\
Alt + Shift + M: Start script in BinarySearch mode\
Esc: End script without error message\
Enter: End script without error message\
Any unbound keys: Exit with error message\
Timout: Exit with error message, default timeout set to 10 minutes

Cursor movement:\
j => Left\
l => Right\
i => Up\
k => Down

Click:\
u => Left click and continue using script\
o => Right click and continue using script\
f => Left click and exit script\
d => Right click and exit script\
e => Mouse4 click, "browser back" and continue using script\
r => Mouse5 click, "browser forward" and continue using script\
h => Click and drag. Press once at the starting location of drag and then press again at ending location of the drag. Continues using script

Scroll:\
; => Scroll down\
' => Scroll up\
: => Scroll right\
" => Scroll left


Modes:\
s => Switch between BinarySearch and Increment mode\
m => (Increment mode only) Decrease number of pixels that the cursor moves by half\
n => (Increment mode only) Increase number of pixels that the cursor moves by 2x\
a => Center the cursor and resets "screen". Reset to BinarySearch mode. Reset the amount of pixels traveled by the cursor in Increment mode

INSTALLATION INSTRUCTIONS
-------------------------
1. Download AutoHotKey from their website: https://www.autohotkey.com/
2. Right-click on desktop and select "New" -> "AutoHotKey Script"
3. Copy Mouse.ahk from Github repository and paste into your newly created script
4. Save
5. Right-click on newly created script and select "Run"


NOTES
-----
On a screen resolution of 1366x768 it takes ~8 key presses to get to any 30x30 target on the screen. Due to the nature of binary searches, a significant increase in screen size would not significantly increase the number of key presses needed to get to any particular area on the screen. This feature, used alongside Increment mode is a fairly efficient alternative to a standard mouse. Also note the fact that many screen targets are larger than 30x30.
