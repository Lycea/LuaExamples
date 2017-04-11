l=love
g=l.graphics
p=0
rm,bm,gm=1,1,1

sh=g.newShader("s")

function l.draw()
  sh:send("m",rm,gm,bm)
  if p~=0 then
    g.setShader(sh)
    g.draw(p)
    g.setShader()
  else
    g.print("Please drop a png file on the screen\nand then press 0/1/2/3 for normal or channel modes")
  end
end



function l.filedropped(f)
  a=f:getFilename()
  p=g.newImage(f)
end

function l.keypressed(k)
  if k=="0"then rm,gm,bm=1,1,1 end
  if k=="1"then rm,gm,bm=1,0,0 end
  if k=="2"then rm,gm,bm=0,1,0 end
  if k=="3"then rm,gm,bm=0,0,1 end
end