local gpu = require("component").gpu
local event = require("event")
local term = require("term")

local buttons = {{2, 2, 11, 1, "hello()", "hello", 0x555555, 0x000000}, {80, 1, 1, 1, "close()", "X", 0xFF0000, 0xFFFFFF}}

local screen_Background_color
local screen_Foreground_color
local screen_Resolution = {}

function saveScreenConfig()
  screen_Background_color = gpu.getBackground()
  screen_Foreground_color = gpu.getForeground()
  screen_Resolution = { gpu.getResolution() }
end

function loadScreenConfig()
  gpu.setBackground(screen_Background_color)
  gpu.setForeground(screen_Foreground_color)
  gpu.setResolution(screen_Resolution[1], screen_Resolution[2])
end

local while_c = true

function textFunc(func)
  if(func=="hello()")then
    cprint("hello")
  end
  if(func=="close()")then
    while_c = false
  end
end

local line = 0
local column = 0

function cprint(text)
  gpu.setBackground(0x111111)
  if(line<=3)then
    gpu.set(14, 21+line, tostring(text))
    line = line + 1
  else
    for i=0, 2 do
      for j=0, 65 do
        getPix = { gpu.get(j+14, i+22) }
        gpu.setBackground(getPix[3])
        gpu.setForeground(getPix[2])
        gpu.set(j+14, i+21, getPix[1])
      end
    end
    gpu.fill(14, 24, 67, 1, " ")
    gpu.set(14, 24, tostring(text))
  end
end

function initButtons()
  for i=1, #buttons do
    cB = buttons[i]
    if(#cB>=4)then
      if(#cB>=8)then
        gpu.setBackground(cB[7])
        gpu.setForeground(cB[8])
      else
        gpu.setBackground(0x000000)
        gpu.setForeground(0x000000)
      end
      gpu.fill(cB[1], cB[2], cB[3], cB[4], " ")
      if(#cB>=6)then
        gpu.set(cB[1], cB[2], cB[6])
      end
    end
  end
end

function drawFrame(x, y, w, h, c1, c2)
  gpu.setBackground(c1)
  gpu.fill(x, y, w, h, " ")
  gpu.setBackground(c2)
  gpu.fill(x+1, y+1, w-2, h-2, " ")
end

function cButtons(xT, yT)
  for i=1, #buttons do
    cB= buttons[i]
    if((xT >= cB[1]) and (yT >= cB[2]) and (xT < cB[1]+cB[3]) and (yT < cB[2]+cB[4]))then
      textFunc(cB[5])
    end
  end
end

saveScreenConfig()

drawFrame(1, 1, 13, 25, 0x444444, 0x111111)
drawFrame(13, 1, 68, 20, 0x444444, 0x111111)
drawFrame(13, 20, 68, 6, 0x444444, 0x111111)

initButtons()

while(while_c)do
  e = { event.pull() }
  if(e[1]=="touch")then
    cButtons(e[3],e[4])
  end
  if(e[1]=="key_down")then
    cprint(e[3])
  end
end

loadScreenConfig()
term.clear()