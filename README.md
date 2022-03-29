# Love2D-GUI-Libs

![Made With Lua](https://img.shields.io/badge/Made%20With-Lua-%232C2D72.svg?style=flat&logo=lua&logoColor=white) ![Version 1.0](https://img.shields.io/badge/Version-1.0-cfc)
![Total Lines of Code](https://img.shields.io/tokei/lines/github/danilus-s/love2d-gui-libs?label=Total%20Lines%20of%20Code&logo=VisualStudioCode)
----
### Description

An easy-to-use library for creating **buttons, tumblers and text input fields** in **Love2D**.
With support of **callbacks, colors, custom text** and more cool stuff.

[Install Guide](#installing-the-library)

# Documentation
---
## Table of Contents
- [Getting Started](#getting-started)
  - [Installing the library](#installing-the-library)
  - [Creating your first GUI element](#creating-your-first-gui-element)
- [Reference](#reference)
  - [gui-button.lua](#gui-buttonlua)
    - Methods
      - [addButton()](#addbuttonxywhtext1bg1fg1functypetext2bg2fg2)
      - [draw()](#draw)
    - Values
      - [button](#button)
      - [buttons](#btnbuttons)
  - [gui-inputfield.lua](gui-inputfieldlua)
    - Methods
      - [addField()](#addfieldxywbufferbgfg)
      - [draw()](#draw-1)
    - Values
      - [field](#field)
      - [fields](#inpfields)

# Getting Started
----
## Installing the library

To install the library, clone the source repository by running the following command in your terminal:
```
git clone https://github.com/Danilus-s/Love2D-GUI-libs.git
```

This will create a folder named `Love2D-GUI-libs`, to actually use the library, copy needed `.lua` files to your project folder.

## Creating your first GUI element

First of all, you need to import our library files to your code, to do so, add the following lines to your code:
```lua
-- incase you need to import button library
local btn = require("gui-button")
-- incase you need to import text input library
local inp = require("gui-inputfield")
```

Now, our files are imported to your code, let's create our first element!
```lua
function love.load()
    -- it's important to create elements inside load() function, to not overload the project when running
    btn.addButton(150, 150, 150, 75, "My First Button!", {1, 1, 1, 1}, {0, 0, 0, 1})
end
```

Tada! Our button is now created! But if you run the project, you'll see that it didn't actually appear on the screen, to fix that, you need to actually **draw** the button.

To do so, add these lines to your code:
```lua
function love.draw()
    -- as you might know, love.draw() is used to constantly update the screen, that's why we need to draw our buttons here aswell
    btn.draw()
    -- btn.draw() loads all existing buttons, so you only need to write it once
end
```

When you did all of this, the code should look like this:
```lua
local btn = require("gui-button")

function love.load()
    btn.addButton(150, 150, 150, 75, "My First Button!", {1, 1, 1, 1}, {0, 0, 0, 1}, nil, 1, nil, nil, nil)
end

function love.draw()
    btn.draw()
end
```

When you run the current project, it should look like this:
![Result 1](https://i.imgur.com/Z0hdE4e.png)

But if you click the button, nothing happens, to make it at least change the color on click, we need to add something to our addButton() function:
```lua
function love.load()
    btn.addButton(150, 150, 150, 75, "My First Button!", {1, 1, 1, 1}, {0, 0, 0, 1}, nil, 1, "You clicked me!", {0.111, 0.111, 0.111, 1}, {1, 1, 1, 1})
end
```

...and our library can't detect when a user clicks on something, so you need to add `love.mousepressed(...)`, `love.mouserelease()` callbacks and `btn.onClick(...)`, `btn.onRelease()` functions.
Add this to your code:
```lua
function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        btn.onClick(x,y)
    end
end

function love.mousereleased(x, y, button, istouch, presses)
    btn.onRelease(x,y)
end
```

With all of that stuff added, our code should look like this:
```lua
local btn = require("gui-button")

function love.load()
    btn.addButton(150, 150, 150, 75, "My First Button!", {1, 1, 1, 1}, {0, 0, 0, 1}, nil, 1, "You clicked me!", {0.111, 0.111, 0.111, 1}, {1, 1, 1, 1})
end

function love.draw()
    btn.draw()
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        btn.onClick(x,y)
    end
end

function love.mousereleased(x, y, button, istouch, presses)
    btn.onRelease(x,y)
end
```

Try running the project now, and if you will click the button, you'll see that it's working!
###### For more info and text inputs, check documentation!
# Reference

---------

# gui-button.lua

### Methods

## `addButton(x,y,w,h,text1,bg1,fg1,func,type,text2,bg2,fg2)`

- `x` - X-Coordinate of the button `(number)`
- `y` - Y-Coordinate of the button `(number)`
- `w` - Width of button's background rectangle `(number)`
- `h` - Height of button's background rectangle `(number)`
- `text1` - Text on the button `(string)`
- `bg1` - Color of button's background rectangle `(table) {r, g, b, a}` | `({1,0,0,1})`
- `fg1` - Color of button's text `(table) {r, g, b, a}` | `({0,1,0,1})`
- `func` - Callback of onClick event `(func)` | `(function() end)`
- `type` - Button type `(number)` `(1)`
  - `1` - Basic button, active when holding/clicking
  - `2` - Switchable tumbler, active when clicked once, inactive when clicked while active.

Note: **Arguments below won't work without `love.mousepressed` and `love.mousereleased` callbacks.**

- `text2` - Text when active `(string)`
- `bg2` - Color of button's background rectangle when active `(table) {r, g, b, a}`
- `fg2` - Color of button's text when active `(table) {r, g, b, a}`


- Return: `id` `(number)` - index of the button in btn.buttons
---
## `draw()`

- Return: `None`

Note: **Has to be executed in `main.lua`, at function `love.draw()`**

---

### Values

## Button
- `table`
  - Structure: 
```lua
    button = {
        x, y, w, h, text1, bg1, fg1, func, type, text2, bg2, fg2, isActive, state
    }
```

## btn.buttons
- `table`
  - Structure: `{{button1}, {button2}, {button3}, ...}`

---

# gui-inputfield.lua

- Note: **All inputfield-elements need `love.mousepressed()`, `love.keypressed()` and `love.textinput()` callbacks, else they just won't work.**

### Methods

## `addField(x,y,w,buffer,bg,fg)`

- `x` - X-Coordinate of the field `(number)`
- `y` - Y-Coordinate of the field `(number)`
- `w` - Width of the field `(number)`
- `buffer` - Input of the field `(string)`
- `bg` - Color of field's background `(table)` | `{1,0,0,1}`
- `fg` - Color of field's text `(table)` | `{0,1,0,1}`

- Return: `id` `(number)` - index of the field in inp.fields

---
## `draw()`

- Return: `None`

Note: **Has to be executed in `main.lua`, at function `love.draw()`**

---

### Values

## field
- `table`
  - Structure: 
```lua
  field = {
    x, y, w, h, buffer, bg, fg, isActive
  }
```

## inp.fields
- `table`
  - Structure: `{{field1}, {field2}, {field3}, ...}`

