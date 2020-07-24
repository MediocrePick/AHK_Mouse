# AHK_Mouse
Control mouse movement with keyboard

There are two modes of movement: Increment and BinarySearch. Increment is the standard method of moving a mouse where a direction key is pressed and then the cursor moves a certain number of pixels in that direction. BinarySearch starts the cursor in the center of the screen which can be conceptually subdivided into 4 "halves" (top half, bottom half, right half, left half). When a direction key is pressed, the mouse jumps to the center of the selected half of the screen and then subdivides that selected half into 4 pieces again. a
