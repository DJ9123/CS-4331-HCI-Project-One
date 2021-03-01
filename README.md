# Domingo Cook - CS 4331 HCI: Project One

## Project Link
[HCI: Project One Report](https://dj9123.github.io/p1DomingoCook/)

## Project Overview
Common uses:
 * Microwaving food for x number of minutes
 * Setting a timer for x number of minutes

Sequence of actions:
 1. (optional) Press timer button
 2. Enter selected time or press +30 seconds

How does the user know what to do?:
 * Text is displayed for most buttons that contain shortcuts
 * Labels surround button groups for combined uses (e.g. "Express cook")

How does the microwave provide feedback to the user?
 * Sounds each time a button is pressed
 * Sounds when timer/microwave is completed
 * Seven segment display for remaining time or messages

Common mistakes:
 * Too many buttons that never get used
 * Hidden sequences the user might not find
 * Buttons may take too long to press

---

## Issues with My Microwave
![Image of real microwave](https://i.imgur.com/2EfoaSO.gif)

### Timer
The digital display is a standard seven segment display. This can cause issues for the 
user if they have issues reading the represented symbols. Additionally, not many symbols 
outside of numbers can be created with this display. The developer has to be creative 
for choosing how words/acronyms are displayed which can further confuse or be unclear to 
the user.

### Quick access
The power level for my microwave is at a static level unless specifically changed through 
the user interface. However, this value is reset for each instance the microwave is in 
use. Some users may prefer having it in a "settings" style where the power level is 
stored across sessions.

While my microwave gives several options for heating food, I either use the +30 seconds
button or the 1-6 minute express cook buttons. These extra buttons can distract the user 
when looking for buttons often used like kitchen timer or power level.

### Accessibility
Occasionally, I need to open the microwave door while my hands are full. A button for 
quickly opening the microwave can help users who have the same issue.

All of the buttons on the microwave are the same color. Outside of the few that are 
within a color group, most of the buttons look very similar. Additionally, the number of 
buttons on the microwave make the interface too crowded and therefore the text for each 
button is very small.

---

## Plans for Fixing Microwave
![Image of microwave design](https://i.imgur.com/zJlRzT9.png)


### Timer
Increase screen resolution:
* Helps the user quickly read important information
* Add support for other language settings
* Add additional info (power level)

### Quick access
Toggle for adjusting power level:
 * Options: [low, medium, high]
 * Displayed next to timer at all times

Slide in circular motion to quickly set times and simplify design

Large, centered Stop/Clear button at bottom

### Accessibility
A button will be added to open the door. This button shall be large enough for the user 
to bump with their elbow or side of their hand.

The Stop/Clear button will be colored differently than all other buttons. Only Power,
Timer, Open Door, and Stop/Pause buttons will be included in the design.

