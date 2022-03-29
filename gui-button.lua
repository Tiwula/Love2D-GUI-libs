local btn = {}

local utf8 = require("utf8")

btn.buttons = {}
btn.fontSize = 20

function btn.addButton(x,y,w,h,text1,bg1,fg1,func,type,text2,bg2,fg2)
  -- выставление значений по умолчанию
  bg1 = bg1 or {1,0,0,1}
  fg1 = fg1 or {0,1,0,1}
  text2 = text2 or text1
  bg2 = bg2 or bg1
  fg2 = fg2 or fg1
  type = type or 1
  func = func or function() end


  local id = #btn.buttons+1
  btn.buttons[id] = {
    x=x,y=y,w=w,h=h, -- Координаты кнопки 
    text1=text1,bg1=bg1,fg1=fg1, -- состояние до нажания
    text2=text2,bg2=bg2,fg2=fg2, -- состояние после нажатия
    type=type,func=func,isActive=true,state=false
    -- тип кнопки, 1 - кнопка, 2 - тумблер
    -- каллбэк при нажатии
    -- активна ли кнопка, будет ли отрисовываться
    -- если тип = 2, нажата ли кнопка
  }
  return id 
end

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

function btn.onRelease(x,y)
  for _,butt in pairs(btn.buttons) do
    if butt.isActive then
      if butt.type == 1 then
        butt.state = false
      end
    end
  end
end

function btn.draw()
  for _,butt in pairs(btn.buttons) do
    if butt.isActive then
      if butt.state == false then
        love.graphics.setColor(butt.bg1)
        love.graphics.rectangle("fill",butt.x,butt.y,butt.w,butt.h,5,5)
        love.graphics.setColor(butt.fg1)
        love.graphics.printf(butt.text1,butt.x,math.floor(butt.y+butt.h/2-btn.fontSize/2),butt.w,"center")
      else
        love.graphics.setColor(butt.bg2)
        love.graphics.rectangle("fill",butt.x,butt.y,butt.w,butt.h,5,5)
        love.graphics.setColor(butt.fg2)
        love.graphics.printf(butt.text2,butt.x,math.floor(butt.y+butt.h/2-btn.fontSize/2),butt.w,"center")
      end
    end
  end
end

return btn