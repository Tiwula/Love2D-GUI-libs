local inp = {}

local utf8 = require("utf8")

inp.fields = {}
inp.fontSize = 20
inp.activeField = 0

function inp.addField(x,y,w,buffer,bg,fg)
  -- выставление значений по умолчанию
  bg = bg or {1,0,0,1}
  fg = fg or {0,1,0,1}
  buffer = buffer or ""

  local id = #inp.fields+1 
  inp.fields[id] = { --inp.fontSize+10
    x=x,y=y,w=w,h=inp.fontSize+10, -- Координаты кнопки 
    buffer=buffer,bg=bg,fg=fg, -- буффер и цвета 
    isActive=true -- активно ли поле ввода, будет ли отрисовываться
  }
  return id 
end

function inp.onClick(x,y)
  local setted = false
  for id,i in pairs(inp.fields) do
    if x >= i.x and x <= i.x+i.w and y >= i.y and y <= i.y+i.h and i.isActive then
      inp.activeField = id
      setted = true
    end
  end
  if not setted then inp.activeField = 0 end
end

function inp.add(key)
  if inp.activeField ~= 0 then
    inp.fields[inp.activeField].buffer = inp.fields[inp.activeField].buffer .. key
  end
end

function inp.key(key)
  if key == "backspace" and inp.activeField ~= 0 then
    local byteoffset = utf8.offset(inp.fields[inp.activeField].buffer, -1)
    if byteoffset then
      inp.fields[inp.activeField].buffer = inp.fields[inp.activeField].buffer:sub(1, byteoffset - 1)
    end
  end
end

local function clamp(x,min,max)
  x = x < min and min or x
  x = x > max and max or x
  log(x)
  return x
end

function inp.draw()
  for id,i in pairs(inp.fields) do -- 200 [100]  100/200=0.5 10*0.5
    if i.isActive then
      local font = love.graphics.getFont()
	    local textWidth = font:getWidth(i.buffer .. (id == inp.activeField and "|" or ""))
      local len = utf8.len(i.buffer)
      local wi = clamp((i.w-25)/textWidth,0,1)
      love.graphics.setColor(i.bg)
      love.graphics.rectangle("fill",i.x,i.y,i.w,i.h,5,5)
      love.graphics.setColor(i.fg)
      local sub_len = math.floor(len*(1-wi))
      if id == inp.activeField then
        love.graphics.printf( (i.buffer .. "|"):sub(sub_len),i.x,math.floor(i.y+i.h/2-inp.fontSize/2),i.w,"left")
      else
        love.graphics.printf( (i.buffer):sub(sub_len),i.x,math.floor(i.y+i.h/2-inp.fontSize/2),i.w,"left")
      end
    end
  end
end

return inp