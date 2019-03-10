local gpu = require("component").gpu
local filesystem = require("filesystem")
local io = require("io")

size = filesystem.size("home/app/app/resourses/icon.pic")
local file = filesystem.open("/home/app/app/resourses/icon.pic", "r")

i = 0

count = tonumber(file:read(1))

xs = ""

for i=1, count do
  xs = xs..file:read(1)
end 

x = tonumber(xs)

count = tonumber(file:read(1))

ys = ""

for i=1, count do
  ys = ys..file:read(1)
end

y = tonumber(ys)


for i=1, y do
  for j=1, x do
    if(file:read(1)=="1")then
      gpu.setBackground(0x00FF77)
    else
      gpu.setBackground(0x000000)
    end
    gpu.set(j, i, " ")
  end
end


file:close()
gpu.setBackground(0x000000)