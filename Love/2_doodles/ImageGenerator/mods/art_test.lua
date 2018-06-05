local mod = {}
local gr = love.graphics
mod.name = "art_test"


local rnd = love.math.random
local sin = math.sin
local flr = math.floor

local draw_ ={}

local update_ ={}
local circ_list = {}
local line_list = {}

function mod.draw()
  gr.setLineWidth(1)
    gr.setColor(1,1,1,255)
    for i,j in ipairs(circ_list) do
      gr.setColor(1,1,1,255)
      gr.circle("fill",j.x,j.y,10)
      
        gr.setColor(j.r,j.g,j.b,150)
        gr.circle("fill",j.x,j.y,50)
    end
    
    gr.setLineWidth(2)
    gr.setColor(1,1,1,100)
    for i,j in ipairs(line_list) do
        gr.line(j.x1,j.y1,j.x2,j.y2)
    end
    
  
  gr.setLineWidth(1)
end

local timer = 0
function mod.update(dt)
  if #circ_list < 10 then
  circ_list[#circ_list+1] ={}
  circ_list[#circ_list].x = rnd(0,1024)
  circ_list[#circ_list].y = rnd(150,768)
  
  circ_list[#circ_list].r = rnd(0,255)
  circ_list[#circ_list].g = rnd(0,255)
  circ_list[#circ_list].b = rnd(0,255)
    if #circ_list > 1 then
      for i = 1, #circ_list -1 do
        line_list[#line_list+1]={}
        line_list[#line_list].x1 = circ_list[#circ_list].x
        line_list[#line_list].y1 = circ_list[#circ_list].y
        
        line_list[#line_list].x2 = circ_list[i].x
        line_list[#line_list].y2 = circ_list[i].y
      end
    end
  else
    timer = timer + dt
    if timer > 3 then
      circ_list ={}
      line_list = {}
      timer = 0
    end
    
  end

end


function mod.ini()
  
  
   love.graphics.setBackgroundColor(255,255,255,255)
end

function mod.reload()
  
  
   love.graphics.setBackgroundColor(255,255,255,255)
end


function mod.unload()
  love.graphics.setBackgroundColor(0,0,0,255)
  
end

return mod