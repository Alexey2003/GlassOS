local gpu = require("component").gpu
local filesystem = require("filesystem")
local io = require("io")

size = filesystem.size("~/app/resourses/icon.pic")
local file = filesystem.open("~/app/resourses/icon.pic", "r")

for i=1, i<10 do
    print(file:read(1).."\n")