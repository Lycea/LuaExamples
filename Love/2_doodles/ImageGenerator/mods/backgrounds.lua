local mod ={}
mod.name = "background generator"


local controls
local gr = love.graphics

local scr_width,scr_height

local image 



local generation_to = 1
local timer = 0
local rnd = love.math.random



local function generate_new()
  --print(generation_to)
  if generation_to < 1 then return end
  print("test")
  gr.setCanvas(image)
  gr.clear(0,0,0,0xff)
  
  local r,g,b= rnd(200,255),rnd(200,255),rnd(200,255) 
  local w = rnd(1,10)
  
  local r_diff = rnd(10, 30)
  local r_max = scr_width /2 + scr_width/3
  local c_edg = rnd(5,15)
  local steps = math.ceil((scr_width/2)/r_diff)
  
  for i = 1,  steps do
    i = i-1
    gr.setColor(r-i*(255/steps),g-i*(255/steps),b-i*(255/steps),255)
    love.graphics.circle("fill",scr_width/2,scr_height/2,r_max-(i*r_diff),c_edg)
    i = i+1
    print(r_max-(i*r_diff))
  end
  
  
  gr.setCanvas()
  generation_to = 0
end



function mod.ini()
  controls =
  {
    ui.AddButton("test",300,0,20,20),
    ui.AddSlider(0,300,50,100,30,0,10)
  }
  
  ui.SetSpecialCallback(controls[1],generate_new)
  
  scr_width  = gr.getWidth()
  scr_height = gr.getHeight()
  
  image = gr.newCanvas(scr_width,scr_height)
  
  generate_new()
end



function mod.update(dt)
  timer = timer + dt
  if generation_to == 1 then return end
  --print("wait till allowed")
  if timer >1 then
  generation_to = 1
  timer = 0
  print("create again")
  end
  
end

function mod.draw()
  love.graphics.draw(image,0,0)
end


function mod.unload()
  
end

function mod.reload()
  
end

return mod