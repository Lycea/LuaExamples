--count = -3
pix_x = 0
array = {}

function love.draw()
--love.graphics.print(arg[2])
--start half of the window on the left
  for _= -3,3,0.05 do
  
     y=math.pow(arg[3],_)*math.cos(math.pi*_)
  --love.graphics.print(y)
     array[#array+1],array[#array+2]=pix_x, love.graphics.getHeight()/2+(y*10)*2
     pix_x=pix_x+1
  end
  love.graphics.line(array)
  love.graphics.print(love.graphics.getHeight().." "..love.graphics.getWidth())
 
  
 
 --count = count+0.001
end