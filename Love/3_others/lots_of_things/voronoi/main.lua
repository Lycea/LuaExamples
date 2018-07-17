
local disc = require("discs")

local rnd_num = love.math.random
function love.load()
  --require("mobdebug").start()
  pts ={}
  gr = love.graphics
  w,h = 0,0

  points = 20
  
  w=gr.getWidth()
  h=gr.getHeight()
  
  canv = gr.newCanvas(w,h)
  
  
  area_ =(w*h)/points --area a voronoi can have if evenly distributed ...
  distance  = math.sqrt(area_/math.pi)  --radius from that ... but make it smaller cause testing
  distance = distance + distance/10
  
  disc.new_points({num_points=points,scr_w =w,scr_h=h,r=distance,runs_per_call = 9999})
  disc.run()
  print(disc.getActiveCount())
  pts =disc.getPoints()
  
  for i=1,#pts do
    local c1,c2,c3 =rnd_num(0,255)/255,rnd_num(0,255)/255,rnd_num(0,255)/255
    pts[i]["r"]=c1
    pts[i]["g"]=c2
    pts[i]["b"]=c3 
  end
  print(#pts)

end
function love.update()
  
end


pots = {}
count = 1

local function dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

function voronoi(x,y,r,g,b,a)
  --calc distance to each point
  local min_d = 10000
  local min_id = 0
  for i=1,#pts do
    if dist(pts[i]["x"],pts[i]["y"],x,y)< min_d then
      min_d = dist(pts[i]["x"],pts[i]["y"],x,y)
      min_id = i
    end
  end
  
  --min_d =  (math.tanh(min_d)*2)*0.5
  c = pts[min_id]
  pots[count]={x,y,pts[min_id].r,pts[min_id].g,pts[min_id].b,1}
  --print(min_d)
  count = count+1
  local uv =  (2*((x-w)+(y-h)))/h
    --print(uv)
  return 0,0,0,1
end
--fancy random function ö.ö
function rnd(x,y)
  a ={x*123.34,y*234.34,x*345.65}
  --dot function kind of :P  put as a own function at some point ... maybe
  b = a[1]*(a[1]+34.45) + a[2]*(a[2]+34.45) + a[3]*(a[3]+34.45)
  --added dot to num
  c ={a[1]+b,a[2]+b,a[3]+b}
  
  -- multiply a[1] * a[2] and  a[2]*a[3] aaaand return the fractal part of these two ?
  r1 = c[1]*c[2]
  i,r1 = math.modf(r1)
  r2 = c[2]*c[3]
  i,r2 = math.modf(r2)
  
  return r1,r2
end


function voronoi2(x,y,r,g,b,a)
  local uv_x = x/w *3 
  local uv_y = y/h *3
  
  --grid borders 
  local i,gv_x = math.modf(uv_x) 
  local i,gv_y = math.modf(uv_y) 
  
  --cell num
  local id_x = math.floor(uv_x)
  local id_y = math.floor(uv_y)
  
  --distant
  local min_d = 10000
  
  --loop the cells
  for i_y = -1,1,1 do
    for i_x = -1,1,1 do
      off ={i_x,i_y}--offset from the middle of a cell ?
      --point ?
      r_x,r_y =rnd(id_x+off[1],id_y+off[2])
      r_x = r_x*0.5
      r_y = r_y*0.5
       d = dist(r_x,r_y,gv_x,gv_y)
       if d < min_d then
         min_d = d
       end
       
    end
  end
  
  --calc distance to each point
  --pots[count] ={x,y,gv_x,gv_y,1} --grid
  --pots[count] ={x,y,id_x*0.1,id_y*0.1,0} --id of grid colored :D
  pots[count] ={x,y,min_d,min_d,0} --distance colored :D
  
  count = count+1
    
  return 0,0,0,1
end


map_new = true
proc_time = 0
function love.draw()
  
  
  pixs =canv:newImageData()
  count = 1
  if map_new == true then
    local start = love.timer.getTime()
    pixs:mapPixel(voronoi)
    proc_time = love.timer.getTime()-start
    map_new = false
  end

  
  gr.setCanvas(canv)
  
  for i=1 ,#pts do
    gr.circle("fill",pts[i]["x"],pts[i]["y"],2)
    --gr.line(0,0,pts[i][1],pts[i][2])
  end
  gr.points( pots)
  gr.setCanvas()
  
  gr.draw(canv)
  
  gr.setColor(0,0,0,0.5)
  gr.rectangle("fill",0,0,200,60)
  gr.setColor(1,1,1,1)
  gr.print("Num points: "..points.."\nTime: "..proc_time.."\nCalc points: "..#pts,0,0)
end



function love.keypressed(key,code,repe)
    if key == "n" then
      pts ={}
      print("------new "..points.."-------")
      c = 0
      local start = love.timer.getTime()
      
      area_ =(w*h)/points --area a voronoi can have if evenly distributed ...
      distance  = math.sqrt(area_/math.pi)  --radius from that ... but make it smaller cause testing
      print(distance)
      distance = math.sqrt(area_)/2
      distance = distance + distance/10
      print(distance)
     -- distance = distance + distance/10
  
      disc.new_points({num_points=points,scr_w =w,scr_h=h,r=distance,runs_per_call = 9999})
      disc.run()
      pts =disc.getPoints()
      
      for i=1,#pts do
        pts[i]["r"],pts[i]["g"],pts[i]["b"] = rnd_num(0,255)/255,rnd_num(0,255)/255,rnd_num(0,255)/255
      end
      
      
      print(disc.getActiveCount())
      print(#pts)      
      print(love.timer.getTime()-start)

      map_new = true
    end
    if key == "left" then
      points = points -5
    end
    if key == "right" then
      points = points +5
    end
    
end
