
local mod ={}

local main_points ={}
local childs = {}
local scr_w,scr_h
local gr = love.graphics
local NUM_MAIN = 5

local level = 2
local start_idx =1
local distance =10

local rnd = math.random
function mod.ini()
  scr_w,scr_h = gr.getWidth(),gr.getHeight()
end

function mod.update(dt)
  local actual_childs = #childs
  for i = start_idx,actual_childs do
    --create 1 new child
    childs[#childs+1] ={p1 = childs[i].p2,
                        p2 ={x= childs[i].p2.y+ (distance/level),y= childs[i].p2.x+ (distance/level)}
                        }
  end
  start_idx = actual_childs
  level = level +1
end

function mod.draw()
  for i_,child in ipairs(childs) do
    gr.line(child.p1.x,child.p1.y,child.p2.x,child.p2.y)
  end
end

function mod.reload()
  main_points = {}
  childs = {}
  
  for i=1,NUM_MAIN do
    childs[i] ={
      p1={
      x= rnd(0,scr_w),
      y= rnd(0,scr_h)
      },
    }
    childs[i].p2 = {}
    childs[i].p2 = {x=childs[i].p1.x +distance,y=childs[i].p1.y+distance}
  end
  
end

function mod.unload()
  
end


return mod