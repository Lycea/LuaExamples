local mod = {}
mod.name = "Template Mod"
local gr = love.graphics
local scr_w,scr_h

local bg 

local set_menu = {}
local ui_objects ={}



local freq = 10
local freq_2 = 2
local seed = 2


local flr = math.floor


local function gen_background()
  local start =love.timer.getTime()
  local points = {}
  local p_1 ={}
  local p_2 ={}
  
  --local freq_tmp = flr(freq)
  for i=1,scr_h/2,1 do
    for j=1,scr_w/2,1 do
      
       local flir = love.math.noise(i/freq ,j/freq,seed,1,1)
       local flir2 = love.math.noise(i/(freq/freq_2) ,j/(freq/freq_2),seed,1,1)
       --local flir3 = love.math.noise(i/(freq/3) ,j/(freq/5),seed*5,1,1)

        p_1[#p_1+1]={j,i,255*flir,255*flir,255*flir,255}
        p_2[#p_2+1]={j,i,255*flir2,255*flir2,255*flir2,255}
      
       --flir = (flir * 0.5 + flir2 *0.3 + flir3*0.2)
       flir = (flir * 0.7 + flir2*0.3)
       
       flir = math.pow(flir,3)
       --flir = flir*1.2
       --flir = flr(flir+0.5) 
       
       if flir < 0.2 then
         points[#points+1]={j,i,255*flir,255*flir,255,255}
       elseif flir < 0.7 then
         points[#points+1]={j,i,255*flir,255,255*flir,255}
       else
        points[#points+1]={j,i,255,255,255,255}
      end
      
      --points[#points+1]={j,i,flir*255,flir*255,flir*255,255}
      -- print(i.." "..j)
      
    end
  end
  
  print((scr_w/2)*(scr_h/2))
  gr.setCanvas(bg)
  gr.clear(0,0,0,255)
  gr.points(points)
  gr.setCanvas()
  
  
  gr.setCanvas(bg2)
  gr.clear(0,0,0,255)
  gr.points(p_1)
  gr.setCanvas()
  
  gr.setCanvas(bg3)
  gr.clear(0,0,0,255)
  gr.points(p_2)
  gr.setCanvas()
  local end_ = love.timer.getTime()
  
  
  print("Run time: "..end_ - start)
end


local function init_slider(item_idx,precision)
    ui_objects[#ui_objects+1] = ui.GetObject(set_menu[item_idx])
    ui_objects[#ui_objects]:setPrecision(precision)
    ui_objects[#ui_objects].visible = false
end

function mod.ini()
    scr_w,scr_h = gr.getWidth(),gr.getHeight()
  
    bg = gr.newCanvas(scr_w,scr_h)
    bg2 = gr.newCanvas(scr_w,scr_h)
    bg3 = gr.newCanvas(scr_w,scr_h)
    
    gen_background()
    
    set_menu = 
    {
      ui.AddSlider(freq,300,0,200,30,0.5,200),
      ui.AddSlider(freq_2,300,30,200,30,0.1,20),
      ui.AddSlider(seed,300,60,200,30,1,200),
      ui.AddCheckbox("colored",550,10,false),
    }

    ui_objects[#ui_objects+1] =ui.GetObject(set_menu[4])
    ui.AddGroup(set_menu,"settings_noise")
    
    init_slider(1,2)
    init_slider(2,0)
    init_slider(3,0)
    
    ui.SetGroupVisible("settings_noise",false)
end




function mod.update()
  if freq ~= ui_objects[1].value or freq_2 ~=ui_objects[2].value or seed ~=ui_objects[3].value then
    freq = ui_objects[1].value
    freq_2 = ui_objects[2].value 
    seed = ui_objects[3].value 
    
    gen_background()
  end
end

function mod.draw()
  love.graphics.clear(0,0,0,255)
  love.graphics.draw(bg,0,0)
  
  love.graphics.draw(bg2,scr_w/2,0)
  love.graphics.draw(bg3,0,scr_h/2)
  
  love.graphics.setColor(255,0,0)
  love.graphics.rectangle("line",0,0,scr_w/2,scr_h/2)
end


function mod.reload()
  
  ui.SetGroupVisible("settings_noise",true)
end


function mod.unload()
  ui.SetGroupVisible("settings_noise",false)
end



return mod