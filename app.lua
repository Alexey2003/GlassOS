local gpu = require("component").gpu
local filesystem = require("filesystem")
local io = require("io")

local palette = { 0x0F0F0F, 0xFFFFFF, 0xFF0000, 0x00FF00, 0x0000FF }

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
    gpu.setBackground(palette[tonumber(file:read(1))])
    gpu.set((j)*2-1, i, "  ")
  end
end


file:close()
gpu.setBackground(0x000000)