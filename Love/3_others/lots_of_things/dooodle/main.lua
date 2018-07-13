
local canv = 0
function love.load()
  canv = love.graphics.newCanvas(600,500)
  
end

local t = 0

x,y,dist=0,0,20
function love.update(dt)
  
  t= t+dt
end

b_x = 400
b_y = 250
function love.draw()
  
  segments = 18 
  angles = 360 / segments
  pts = {}
  love.graphics.setCanvas(canv)
  --love.graphics.setColor(1,1,1,0.5)
  for i=1,segments do
    dist = 150
    if i%2 == 1 then
      dist = math.sin(t)*30 + 150
    else
      dist = math.cos(t)*30 + 150
    end
    
    
    x=b_x +math.sin(math.rad(angles*i))*dist
    y=b_y +math.cos(math.rad(angles*i))*dist
    table.insert(pts,{x,y})
    
    if #pts >1 then
      love.graphics.line(x,y,pts[#pts-1][1],pts[#pts-1][2])
    end
    
   -- love.graphics.circle("line",x,y,2)
  end
  love.graphics.line(pts[1][1],pts[1][2],pts[#pts][1],pts[#pts][2])
  
  love.graphics.setCanvas()
  
  love.graphics.draw(canv,0,0)
end