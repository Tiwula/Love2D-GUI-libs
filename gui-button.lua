local btn = {}
btn.font = nil

local utf8 = require("utf8")

btn.buttons = {}
btn.fontSize = 20

---Adds a button to the button list
---@param x number
---@param y number
---@param w number
---@param h number
---@param text1 string
---@param text2 string|nil
---@param bg1 table|nil
---@param bg2 table|nil
---@param func function|nil
---@param fg1 table|nil
---@param fg2 table|nil
---@param type number
---@param bg3 table|nil
---@param fg3 table|nil
---@param text3 string|nil
---@returns number
---@nodiscard
function btn.addButton(x,y,w,h,text1,bg1,fg1,func,type,text2,bg2,fg2,text3,bg3,fg3)
  -- выставление значений по умолчанию
  bg1 = bg1 or {1,0,0,1}
  fg1 = fg1 or {0,1,0,1}
  text2 = text2 or text1
  bg2 = bg2 or bg1
  fg2 = fg2 or fg1
  type = type or 1
  func = func or function() end
  bg3 = bg3 or bg1
  fg3 = fg3 or fg1
  text3 = text3 or text1

  local id = #btn.buttons+1
  btn.buttons[id] = {
    x=x,y=y,w=w,h=h,
    text1=text1,bg1=bg1,fg1=fg1,
    text2=text2,bg2=bg2,fg2=fg2,
    type=type,func=func,isActive=true,state=false,
    bg3=bg3,fg3=fg3,text3=text3
  }
  return id 
end

---Mouse event
---@param x number
---@param y number
---@returns nothing
function btn.onClick(x,y)
  for _,butt in pairs(btn.buttons) do
    if x >= butt.x and x <= butt.x+butt.w and y >= butt.y and y <= butt.y+butt.h and butt.isActive then
      if butt.type == 1 then
        butt.state = true
        butt.func()
      elseif butt.type == 2 then
        if butt.state == false then
          butt.state = true
          butt.func()
        elseif butt.state == true then
          butt.state = false
        end
      end
    end
  end
end

---Mouse event
---@param x number
---@param y number
---@returns nothing
function btn.onRelease(x,y)
  for _,butt in pairs(btn.buttons) do
    if butt.isActive then
      if butt.type == 1 then
        butt.state = false
      end
    end
  end
end

---Draw all buttons
function btn.draw()
  for _,butt in pairs(btn.buttons) do
    if butt.isActive then
      if butt.state == false then
        love.graphics.setColor(butt.bg1)
        love.graphics.rectangle("fill",butt.x,butt.y,butt.w,butt.h,5,5)
        love.graphics.setColor(butt.fg1)
        love.graphics.printf(butt.text1,btn.font or nil,butt.x,math.floor(butt.y+butt.h/2-btn.fontSize/2),butt.w,"center")
      else
        love.graphics.setColor(butt.bg2)
        love.graphics.rectangle("fill",butt.x,butt.y,butt.w,butt.h,5,5)
        love.graphics.setColor(butt.fg2)
        love.graphics.printf(butt.text2,btn.font or nil,butt.x,math.floor(butt.y+butt.h/2-btn.fontSize/2),butt.w,"center")
      end
      if butt.hover --[[and butt.bg3 ~= nil and butt.fg3 ~= nil]] then
        love.graphics.setColor(butt.bg3)
        love.graphics.rectangle("fill",butt.x,butt.y,butt.w,butt.h,5,5)
        love.graphics.setColor(butt.fg3)
        love.graphics.printf(butt.text3,btn.font or nil,butt.x,math.floor(butt.y+butt.h/2-btn.fontSize/2),butt.w,"center")
      end
    end
  end
end

---Mouse event
---@param x number
---@param y number
---@param dx number
---@param dy number
---@returns nothing
function btn.mousemoved(x, y, dx, dy)
  for _,butt in pairs(btn.buttons) do
    if butt.isActive then
      if butt.type == 1 then
        if x >= butt.x and x <= butt.x+butt.w and y >= butt.y and y <= butt.y+butt.h then
          butt.hover = true
        else
          butt.hover = false
        end
      end
    end
  end
end

return btnlocal btn = {}
btn.font = nil

local utf8 = require("utf8")

btn.buttons = {}
btn.fontSize = 20

---Adds a button to the button list
---@param x number
---@param y number
---@param w number
---@param h number
---@param text1 string
---@param text2 string|nil
---@param bg1 table|nil
---@param bg2 table|nil
---@param func function|nil
---@param fg1 table|nil
---@param fg2 table|nil
---@param type number
---@param bg3 table|nil
---@param fg3 table|nil
---@param text3 string|nil
---@returns number
---@nodiscard
function btn.addButton(x,y,w,h,text1,bg1,fg1,func,type,text2,bg2,fg2,text3,bg3,fg3)
  -- выставление значений по умолчанию
  bg1 = bg1 or {1,0,0,1}
  fg1 = fg1 or {0,1,0,1}
  text2 = text2 or text1
  bg2 = bg2 or bg1
  fg2 = fg2 or fg1
  type = type or 1
  func = func or function() end
  bg3 = bg3 or bg1
  fg3 = fg3 or fg1
  text3 = text3 or text1

  local id = #btn.buttons+1
  btn.buttons[id] = {
    x=x,y=y,w=w,h=h,
    text1=text1,bg1=bg1,fg1=fg1,
    text2=text2,bg2=bg2,fg2=fg2,
    type=type,func=func,isActive=true,state=false,
    bg3=bg3,fg3=fg3,text3=text3
  }
  return id 
end

---Mouse event
---@param x number
---@param y number
---@returns nothing
function btn.onClick(x,y)
  for _,butt in pairs(btn.buttons) do
    if x >= butt.x and x <= butt.x+butt.w and y >= butt.y and y <= butt.y+butt.h and butt.isActive then
      if butt.type == 1 then
        butt.state = true
        butt.func()
      elseif butt.type == 2 then
        if butt.state == false then
          butt.state = true
          butt.func()
        elseif butt.state == true then
          butt.state = false
        end
      end
    end
  end
end

---Mouse event
---@param x number
---@param y number
---@returns nothing
function btn.onRelease(x,y)
  for _,butt in pairs(btn.buttons) do
    if butt.isActive then
      if butt.type == 1 then
        butt.state = false
      end
    end
  end
end

---Draw all buttons
function btn.draw()
  for _,butt in pairs(btn.buttons) do
    if butt.isActive then
      if butt.state == false then
        love.graphics.setColor(butt.bg1)
        love.graphics.rectangle("fill",butt.x,butt.y,butt.w,butt.h,5,5)
        love.graphics.setColor(butt.fg1)
        love.graphics.printf(butt.text1,btn.font or nil,butt.x,math.floor(butt.y+butt.h/2-btn.fontSize/2),butt.w,"center")
      else
        love.graphics.setColor(butt.bg2)
        love.graphics.rectangle("fill",butt.x,butt.y,butt.w,butt.h,5,5)
        love.graphics.setColor(butt.fg2)
        love.graphics.printf(butt.text2,btn.font or nil,butt.x,math.floor(butt.y+butt.h/2-btn.fontSize/2),butt.w,"center")
      end
      if butt.hover --[[and butt.bg3 ~= nil and butt.fg3 ~= nil]] then
        love.graphics.setColor(butt.bg3)
        love.graphics.rectangle("fill",butt.x,butt.y,butt.w,butt.h,5,5)
        love.graphics.setColor(butt.fg3)
        love.graphics.printf(butt.text3,btn.font or nil,butt.x,math.floor(butt.y+butt.h/2-btn.fontSize/2),butt.w,"center")
      end
    end
  end
end

---Mouse event
---@param x number
---@param y number
---@param dx number
---@param dy number
---@returns nothing
function btn.mousemoved(x, y, dx, dy)
  for _,butt in pairs(btn.buttons) do
    if butt.isActive then
      if butt.type == 1 then
        if x >= butt.x and x <= butt.x+butt.w and y >= butt.y and y <= butt.y+butt.h then
          butt.hover = true
        else
          butt.hover = false
        end
      end
    end
  end
end

return btn
