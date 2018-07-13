local gr = love.graphics




function love.load()
  
  
end


local hexs  ={}
local circs ={}
local rects ={}
local line  ={}

local mouse_time =0

local rad_act = 4

function love.update(dt)
  
  if love.mouse.isDown(1) and mouse_time >0.25 then
    mouse_time = 0
    local x,y =love.mouse.getPosition()
    
    hexs[#hexs+1] ={}
    hexs[#hexs].x = x
    hexs[#hexs].y = y
    hexs[#hexs].r = rad_act
  end
  mouse_time = mouse_time +dt
  
end

local w_line = 3

local function hex(x,y,rad)
  --glow color
  gr.setColor(1,0,0,0.4)
  --glow lines
  gr.circle("line", x,y,rad-1*w_line,6)
  gr.circle("line", x,y,rad+1*w_line,6)
  
  --main line
  gr.setColor(0,0,0,1)
  gr.circle("line", x,y,rad,6)
end

local function circ(x,y,rad)
  --glow color
  gr.setColor(1,0,0,0.4)
  --glow lines
  gr.circle("line", x,y,rad-1*w_line)
  gr.circle("line", x,y,rad+1*w_line)
  
  --main line
  gr.setColor(0,0,0,1)
  gr.circle("line", x,y,rad)
end

function love.draw()
  
  gr.setBackgroundColor(1,1,1,100)
  gr.setLineWidth(w_line)
  
  local x,y =love.mouse.getPosition()
  
  for i=1,#hexs do
    local o = hexs[i]
    hex(o.x,o.y,o.r)
  end
  
  
  hex(x,y,rad_act)
  
end

function love.wheelmoved(x,y)
  if y >0 then
    --moved up
    rad_act = rad_act +1
  else
    --moved down
    rad_act = rad_act -1
  end
  
end

function love.keypressed(k,s,r)
  
end


