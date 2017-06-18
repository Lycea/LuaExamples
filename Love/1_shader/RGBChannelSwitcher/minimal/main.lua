l=love
    g=l.graphics
    p=0
    rm,bm,gm=1,1,1
    s = [[uniform float m[4];
    vec4 effect(vec4 co,Image t,vec2 c,vec2 s){vec4 p=Texel(t,c);p.r = p.r * m[0];p.b = p.b * m[1]; p.g = p.g * m[2]; return p;}
    ]]sh=g.newShader(s)
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
