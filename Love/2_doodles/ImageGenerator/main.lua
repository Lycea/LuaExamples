
ui = require("SimpleUI.SimpleUI")
--require('cindy.cindy').applyPatch()

local mod_dir = {}
local mods = {}

local actual_mod = 1


local sel_menue = {}
local sli_sel 

function recursiveEnumerate(folder, fileTree)
	local lfs = love.filesystem
	local filesTable = lfs.getDirectoryItems(folder)
	for i,v in ipairs(filesTable) do
		local file = folder.."/"..v
		if lfs.isFile(file) then
			mod_dir[#mod_dir+1] = file
		elseif lfs.isDirectory(file) then
			fileTree = fileTree.."\n"..file.." (DIR)"
			fileTree = recursiveEnumerate(file, fileTree)
		end
	end
	return fileTree
end


function love.load()

  --debugstuff
    for i ,argu in ipairs(arg) do
      --print (argu)
      if argu == "-debug" then
        require("mobdebug").start()   
      end
  end
  
  ui.init()
  

  
  
  
  --load all the modules
  recursiveEnumerate("mods", "")
  
  for _,mod in pairs(mod_dir) do
    --print(mod)
    mod =string.gsub(mod,"/","."):gsub(".lua","")
    --print(mod)
    mods[#mods+1] = require(mod)
    mods[#mods].ini()
  end
  
  
  --start up the default menue
    sel_menue =
  {
    ui.AddSlider(actual_mod,0,0,100,30,1,#mods)
  }
   sli_sel= ui.GetObject(sel_menue[1])
   sli_sel:setPrecision(0)
   
   mods[actual_mod].reload()
end


function love.update(dt)
  if actual_mod ~= sli_sel.value then
    mods[actual_mod].unload()
    actual_mod = sli_sel.value
    mods[actual_mod].reload()
  end
  
  mods[actual_mod].update(dt)
  ui.update(dt)
end


local function draw_panel()
  love.graphics.setColor(0,0,0,150)
  love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),150)
  love.graphics.setColor(0xff,0xff,0xff,255)
  
  
  love.graphics.print(mods[actual_mod].name or "no_name",0, 50)
  love.graphics.line(200,0,200,150)
end

function love.draw()
  mods[actual_mod].draw()
  

  draw_panel()
  ui.draw()
  
end



function love.keypressed(key)
  if key == "escape"then
    love.event.quit()
  end
end


