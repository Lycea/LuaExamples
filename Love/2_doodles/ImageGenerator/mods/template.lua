local mod = {}
mod.name = "Template Mod"
local gr = love.graphics
local scr_w,scr_h

local bg 

local set_menu = {}
local function gen_background()
  local points = {}
  
  for i=0,scr_h do
    for j=0,scr_w do
       local flir = love.math.noise(i/10 ,j/10)
       points[#points+1]={j,i,255*flir,255*flir,255*flir,255}
    end
  end
  
  gr.setCanvas(bg)
  gr.points(points)
  gr.setCanvas()
  
  
end

function mod.ini()
    scr_w,scr_h = gr.getWidth(),gr.getHeight()
  
    bg = gr.newCanvas(scr_w,scr_h)
    gen_background()
    
    set_menu = 
    {
      ui.AddSlider(1,0,300,100,30,1,1^5)
      }
end




function mod.update()
  gen_background()
end

function mod.draw()
  love.graphics.draw(bg,0,0)
end


function mod.drawUi()
  
end


return mod