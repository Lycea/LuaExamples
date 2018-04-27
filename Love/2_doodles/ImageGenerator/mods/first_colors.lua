local mod = {}

local drawing ={}
local rnd = love.math.random
local flr = math.floor
local scr_w,scr_h

local draw_modes = {"fill","line"}
local canv

function mod.drawUi()

end



function mod.ini()
  scr_w ,scr_h = love.graphics.getWidth(),love.graphics.getHeight()
  canv = love.graphics.newCanvas(scr_w,scr_h)
end






drawing[1] =function ()
  local x,y,w,h,seg =rnd(scr_w-30),rnd(scr_h - 30),rnd(50),rnd(50),rnd(10)
  local r_x,r_y =rnd(flr(w/2)),rnd(flr(h/2))
  love.graphics.rectangle(draw_modes[rnd(#draw_modes)],x,y,w,h,r_x,r_y,seg)
end


time = 0
function mod.update(dt)
  time = time+dt*10
  print(time.." "..dt)
end

  
  
function mod.draw()
  --make the randomness happen!!
  love.graphics.setCanvas(canv)
    print(20/time)
    for i=1, 20/time do
      love.graphics.setColor(rnd(255),rnd(255),rnd(255),rnd(255))
      drawing[1]()
    end
  love.graphics.setCanvas()
  love.graphics.setColor(0xff,0xff,0xff,0xff)
  
  --post effects!!
  local pic = canv:newImageData()
  local points ={}
  for i =0, 3000 do
    local x,y = rnd(scr_w-3),rnd(scr_h-3)
    local r,g,b,a = pic:getPixel(x,y)
    
    
    points[#points+1]={x,y,r-20,g-20,b-20,a}
  end
  love.graphics.setPointSize(15)
  love.graphics.setCanvas(canv)
  love.graphics.points(points)
  love.graphics.setCanvas()
    
  love.graphics.setColor(0xff,0xff,0xff,0xff)
  love.graphics.draw(canv)
end


return mod
  