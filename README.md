# Drawing_app

This project is an interview challenge, which is a drawing app made using Flutter version 3.27.2.

## Getting Started

You can just run `flutter run` to start the app, or you can generate an apk file and install it on your phone (android phones).

## Design decisions

- The app has a single screen, which is a drawing screen. I put the switch button between drawing mode and pan/zoom mode
in the app bar, because it doesn't affect the drawing experience.

- I added a scrollable bar with color options at the bottom of the screen, which are highlighted with a black circle around them 
when selected. I added the eraser as the last item in this list (with a different icon).

- The UI was separated in different files, and the code was structured in a way that makes it easy to maintain.

- All tokens, spaces, constants and message string are in separate files, so they can be used in different places and 
changed as needed.

# State Management

- Since the app doesn't need many complex UI changes (like loading screens, error screens, placeholders), I decided to 
use Provider as the state manager. There are other options like bloc/cubit which are great for larger apps that need 
to scale, but in the case of this challenge it would be unnecessary boilerplate, since there is no "silver bullet" for 
state management.

# Challenges encountered and solutions applied

- Working with the zoom update at the same time as the drawing increased proportionally was a big challenge, which I 
solved using the InteractiveViewer in both functionalities (zoom/pan and drawing), but using the same controller to 
reflect the previously made drawing the applied zoom scale.

- In the functionality of keeping the SVG black strokes visible, I applied a logic of ordering the stack 
items so that the svg layer would always overlap the drawing layer.

- I implemented the eraser functionality by simply painting it the same color as the background of the widget where the 
SVG is inserted (because it is transparent). Obviously, the color must come from a single source in both places. In this
case, the use of color tokens made this implementation easier.

- I implemented the function of clearing the screen with the external package called shake_gesture and calling a method 
that clears the drawings on the screen. In some cases it has some strange behaviors of not clearing or clearing with any
small movement of the cell phone (it needs some improvements/optimizations in my code).

# Assumptions made during the development

- I assumed that the user will use the app in a landscape mode, so I did not implement the functionality to rotate the 
screen.

- I assumed that the UI didn't need to be identical to the one shown in the examples, it just had to follow the listed 
core requirements.