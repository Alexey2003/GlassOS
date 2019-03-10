local gpu = require("component").gpu

size = filesystem.size("./app/resourses/icon.pic")
local file = filesystem.open("./app/resourses/icon.pic", "r")
print(file.read(size))