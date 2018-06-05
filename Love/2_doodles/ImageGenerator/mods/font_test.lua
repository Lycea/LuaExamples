local mod = {}
mod.name = "Font_test"


local start ={}

function mod.ini()
  --start pos
  start.x = love.math.random(0, 300)
  start.y = love.math.random(0, 300)
end





function mod.update(dt)
  local ti = love.timer.getTime()
   sin = math.sin(ti)
  
  start.x = start.x +3
  start.y = 10* math.sin(3*start.x)
end


function mod.draw()
  love.graphics.circle("line",start.x,start.y,12)
  love.graphics.print(sin,0,300)
end



function mod.reload()
  
end



function mod.unload()
  
end

return mod