local mod = {}


local gr = love.graphics

local num = 90
local center = {x = 300,y = 300}
local dest   = {}

local time = 0

function mod.update(dt)
  if time > 3 then
    num = num +90
    dest.x =  100*math.sin(math.rad(num))+ center.x
    dest.y =  50*math.cos(math.rad(num))+ center.y
    time = 0
    
  end
  time = time + dt
end

function mod.draw()
  gr.circle("line",center.x,center.y, 10)
  gr.circle("line",dest.x,dest.y,10)
  
  gr.print(num,0,150)
end


function mod.ini()
  dest.x =  100*math.sin(math.rad(num))+ center.x
  dest.y =  50*math.cos(math.rad(num))+ center.y
end

function mod.reload()
  
end


function mod.unload()
  
end

return mod