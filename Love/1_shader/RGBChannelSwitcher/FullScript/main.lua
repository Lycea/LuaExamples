
l = love
p = 0

rm = 1
bm = 1
gm = 1



sh = love.graphics.newShader("outline.glsl")
function l.load()
  require ("mobdebug").start()
  
  
end



function l.draw()
  
  sh:send("multi",rm,gm,bm,bm)
  if p~=0 then
    --[[
    if k ~= old then
     data = p:getData()
     data_2 = love.image.newImageData(p:getWidth(),p:getHeight())
    end
    for w=1,p:getWidth()-1 do
        for h=1,p:getHeight()-1 do
          r ,g,b = data:getPixel(w,h)
          data_2:setPixel(w,h,r*rm,g*gm,b*bm)
        end
    end
    if k ~= old then
     q = love.graphics.newImage(data_2)
     old = k
    end]]
  love.graphics.setShader(sh)
  love.graphics.draw(p);
  love.graphics.setShader()
  end
end



function l.filedropped(f)
    a = f:getFilename()
    p = l.graphics.newImage(f)
end

function l.keypressed(k)
  if k == "0" then
  rm = 1
  gm = 1
  bm = 1
  end
  if k=="1"then
  rm = 1
  gm = 0
  bm = 0
  end
  if k=="2"then
  rm = 0
  gm = 1
  bm = 0
  end
  if k == "3" then
  rm = 0
  gm = 0
  bm = 1
  end
end