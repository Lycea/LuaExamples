local mod = {}
mod.name = "Template Mod"
local gr = love.graphics
local scr_w,scr_h

local bg 

local set_menu = {}
local ui_objects ={}


-- available options
local freq = 10
local freq_2 = 2
local seed = 2
local draw_color = false
local show_preview = true

--color options
local water_leve = 0.3  -- always smaller this
local beach_level = 0.5
local forest_level = 0.7





local flr = math.floor




local function gen_background()
  local start =love.timer.getTime()
  local points = {}
  local p_1 ={}
  local p_2 ={}
  
  print(freq)
  --local freq_tmp = flr(freq)
  for i=1,scr_h/2,1 do
    for j=1,scr_w/2,1 do
      
       local flir = love.math.noise(i/freq ,j/freq,seed,1)
       local flir2 = love.math.noise(i/(freq/freq_2) ,j/(freq/freq_2),seed,1)
       local flir3 = love.math.noise(i/(freq/freq_2)*2 ,j/(freq/freq_2)/2,seed,1)
       --local flir3 = love.math.noise(i/(freq/3) ,j/(freq/5),seed*5,1,1)
      
        if show_preview == true then
        p_1[#p_1+1]={j,i,255*flir,255*flir,255*flir,255}
        p_2[#p_2+1]={j,i,255*flir2,255*flir2,255*flir2,255}
        end
      
       --flir = (flir * 0.5 + flir2 *0.3 + flir3*0.2)
       flir = (flir * 0.5 + flir2*0.3 +flir3*0.2)
       
       flir = math.pow(flir,1)
       flir = flir*1.2
       --flir = flr(flir+0.5) 
       
       if draw_color == true then
       
         if flir < water_leve then
           points[#points+1]={j,i,255*flir,255*flir,255,255}
         elseif flir < beach_level then
           points[#points+1]={j,i,249,242,235}
         elseif flir < forest_level then
           points[#points+1]={j,i,255*flir,255,255*flir,255}
         else
          points[#points+1]={j,i,255,255,255,255}
         end
       else
        points[#points+1]={j,i,flir*255,flir*255,flir*255,255}
      -- print(i.." "..j)
      end
    end
  end
  
  print((scr_w/2)*(scr_h/2))
  gr.setCanvas(bg)
  gr.clear(0,0,0,255)
  gr.points(points)
  gr.setCanvas()
  
  if show_preview == true then
    gr.setCanvas(bg2)
    gr.clear(0,0,0,255)
    gr.points(p_1)
    gr.setCanvas()
    
    gr.setCanvas(bg3)
    gr.clear(0,0,0,255)
    gr.points(p_2)
    gr.setCanvas()
  end
  
  local end_ = love.timer.getTime()
  
  
  print("Run time: "..end_ - start)
end


local function init_slider(item_idx,precision)
    ui_objects[#ui_objects+1] = ui.GetObject(item_idx)
    ui_objects[#ui_objects]:setPrecision(precision)
    ui_objects[#ui_objects].visible = false
end

function mod.ini()
    scr_w,scr_h = gr.getWidth(),gr.getHeight()
  
    bg = gr.newCanvas(scr_w,scr_h)
    bg2 = gr.newCanvas(scr_w,scr_h)
    bg3 = gr.newCanvas(scr_w,scr_h)
    
    
    
    set_menu = 
    {
      ui.AddSlider(freq,200,0,200,30,1,200),
      ui.AddSlider(freq_2,200,30,200,30,0.1,20),
      ui.AddSlider(seed,200,60,200,30,1,200),
      ui.AddCheckbox("colored",450,10,draw_color),
      ui.AddCheckbox("preview",450,40,show_preview),
    }

    
    color_menu =
    {
      ui.AddSlider(water_leve,510,0,200,30,0,1), -- level water
      ui.AddSlider(beach_level,510,30,200,30,0,1), -- level beach
      ui.AddSlider(forest_level,510,60,200,30,0,1), -- level forest
      }
    --noise menu
    init_slider(set_menu[1],0)
    init_slider(set_menu[2],0)
    init_slider(set_menu[3],0)
     print("ui objecs: "..#ui_objects)
     
         --checkboxes
    ui_objects[#ui_objects+1] =ui.GetObject(set_menu[4])
    ui_objects[#ui_objects+1] =ui.GetObject(set_menu[5])
     
     
    --color menu
    init_slider(color_menu[1],3)
    init_slider(color_menu[2],3)
    init_slider(color_menu[3],3)
     print("ui objecs: "..#ui_objects)

    
    print("ui objecs: "..#ui_objects)
    ui.AddGroup(set_menu,"noise")
    ui.AddGroup(color_menu,"color")
    
    ui.SetGroupVisible("noise",false)
    ui.SetGroupVisible("color",false)
    
    gen_background()
end




function mod.update()
  if freq ~= ui_objects[1].value or freq_2 ~=ui_objects[2].value or seed ~=ui_objects[3].value or  draw_color ~= ui_objects[4].checked 
    or show_preview ~= ui_objects[5].checked  or water_leve ~= ui_objects[6].value or beach_level ~= ui_objects[7].value  
    or forest_level ~= ui_objects[8].value  then
    freq = ui_objects[1].value
    freq_2 = ui_objects[2].value 
    seed = ui_objects[3].value 
    draw_color = ui_objects[4].checked 
    show_preview = ui_objects[5].checked 
    
    water_leve = ui_objects[6].value
    beach_level = ui_objects[7].value
    forest_level = ui_objects[8].value 
    
    ui.SetGroupVisible("color",draw_color)
    
    gen_background()
  end
end

function mod.draw()
  love.graphics.clear(0,0,0,255)
  love.graphics.draw(bg,0,0+150)
  
   if show_preview == true then
  love.graphics.draw(bg2,scr_w/2,0+150)
  love.graphics.draw(bg3,0,scr_h/2+150)
  end
  
  love.graphics.setColor(255,0,0)
 -- love.graphics.rectangle("line",0,0,scr_w/2,scr_h/2)
end


function mod.reload()
  
  ui.SetGroupVisible("noise",true)
  if draw_color then
    ui.SetGroupVisible("color",true)
  end
  
end


function mod.unload()
  ui.SetGroupVisible("noise",false)
  ui.SetGroupVisible("color",false)
end



return mod