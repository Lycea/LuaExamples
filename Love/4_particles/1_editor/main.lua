img_path   = "pics/"
saves_path = "saves/"
require "imgui"



spreadDist     ={"uniform","normal"--[[,"ellipse"]],"none"}
blendModes     ={"alpha","replace","screen","add","subtract","multiply","lighten","darken"}
alphaBlendMode ={"alphamultiply","premultiplied"}
saved_files ={}
 pictures ={}
 pic_names ={}
 act_pic =1



function loadFiles()
  require "dir_test"
  files = start(arg[1])
  saved_files ={}
  pictures ={}
  
  
  local i = true
  local co = 1
  while i == true do
   if files[co].name == "1_editor" then
    for j=1, #files[co].child do
      if files[co].child[j].name == "saves" then
        for l=1, #files[co].child[j].child do
          if  files[co].child[j].child[l].name:match(".-%.cfg") then
            saved_files[#saved_files+1]= files[co].child[j].child[l].name
          end
        end 
      end
      if files[co].child[j].name == "pics" then
        for l=1, #files[co].child[j].child do
           if  files[co].child[j].child[l].name:match(".-%.png") then
            pictures[#pictures+1] =love.graphics.newImage(img_path..files[co].child[j].child[l].name)
            pic_names[#pic_names+1] = files[co].child[j].child[l].name
          end
        end 
      end
    end
    i = false
   end
   co = co+1
  end
end



function love.load()
  require("mobdebug").start()
  
  love.graphics.print("test")
  love.graphics.present()
	particle = love.graphics.newImage(img_path.."snow.png")
	my_system = love.graphics.newParticleSystem(particle, 200)
  loadFiles()
  my_system:start()
end


function love.update(dt)
  my_system:update(dt)
  imgui.NewFrame()
end

speed={radial={0,0},linear={0,0,0,0},tangent={0,0},min=1,max=2}

sizes = {1,0.5,1.5,2,3}
sizes_temp ={}
size_diff = 0.5
num_sizes = 1

p_life_min = 0
p_life_max = 10

val = 440
val2 = 330
val3 = 1
val4 = 0
cur = 1
distx = 0
disty = 0
life = -1
rate = 1
blendM = 1
blendA = 1
colors = 1
mode = 1

spread = 0
ins_modes ={"top","bottom","random"}


a_colors ={{1,1,1,1},{1,1,1,1},{1,1,1,1},{1,1,1,1},{1,1,1,1},{1,1,1,1},{1,1,1,1},{1,1,1,1}}
function love.draw()
  colors_temp = {255,255,255,255}
  --imgui.ShowTestWindow(true)
 
  
  imgui.SetNextWindowPos(0,0)
  imgui.SetNextWindowContentWidth(350)
  imgui.SetNextWindowSize(200,love.graphics.getHeight())
  imgui.Begin("select",true,{"NoResize","NoTitleBar","NoMove","HorizontalScrollbar"})
  --emition
  
  imgui.PushItemWidth(119)
  
    
    s,act_pic = imgui.Combo("Tile",act_pic,pic_names,#pic_names)
    
    
    imgui.Text("Colors")
    s,colors = imgui.SliderInt("Num",colors,1,8)
    for i=1,colors do
      s ,a_colors[i][1],a_colors[i][2],a_colors[i][3],a_colors[i][4] = imgui.ColorEdit4(i..".Color",a_colors[i][1],a_colors[i][2],a_colors[i][3],a_colors[i][4])
    end
  
    imgui.Separator()
    imgui.Text("Blend Mode")
    s,blendM = imgui.Combo(" ",blendM,blendModes,8)
    imgui.SameLine() 
    s,blendA = imgui.Combo("",blendA,alphaBlendMode,2)
  
    imgui.Separator()
     imgui.Text("Emiton")
     s,val,val2 = imgui.SliderInt2("Position",val,val2,0,love.graphics.getWidth())
     s,val3 = imgui.SliderInt("Number",val3,0,300)
     s,val4 = imgui.SliderAngle("Direction",val4,0,360)
    
     s,life = imgui.SliderInt("Lifetime",life,-1,200)
     s,rate = imgui.SliderInt("Rate",rate,0,300)
   
    imgui.Separator()
     imgui.Text("Rotation")
     imgui.Separator()
     imgui.Text("Spin")
     imgui.Separator()
     imgui.Text("Size")
     s,size_diff = imgui.SliderFloat("Diff",size_diff,0,1)
     s,num_sizes =imgui.SliderInt("Sizes",num_sizes,1,5)
     for i= 1 ,num_sizes do
     s,sizes[i] = imgui.SliderFloat("size "..i,sizes[i],0,10)
     end
     
     imgui.Separator()
     imgui.Text("Particle")
     s,speed.radial[1],speed.radial[2] = imgui.SliderInt2("ACC Radial",speed.radial[1],speed.radial[2],0,360)
     s,speed.linear[1],speed.linear[2] = imgui.SliderInt2("",speed.linear[1],speed.linear[2],0,300)
     imgui.SameLine()
     s,speed.linear[3],speed.linear[4] = imgui.SliderInt2("ACC Linear",speed.linear[3],speed.linear[4],0,300)
     s,speed.tangent[1],speed.tangent[2] = imgui.SliderInt2("ACC Tangent",speed.tangent[1],speed.tangent[2],0,300)
     s,speed.min,speed.max = imgui.SliderInt2("Speed",speed.min,speed.max,0,300)
     s,p_life_min,p_life_max = imgui.SliderInt2("Life",p_life_min,p_life_max,0,300)
     s,mode = imgui.Combo("Insertion",mode,ins_modes,3)
     s,spread = imgui.SliderInt("Spread",spread,0,360)
   
    imgui.Separator()
    imgui.Text("Area spread")
    s,cur = imgui.Combo("Spread style",cur,spreadDist,3)
    s,distx,disty = imgui.SliderInt2("Distribution",distx,disty,0,love.graphics.getWidth())
  imgui.PopItemWidth()
  imgui.End()
  
  colors_temp = {}
  local k=1
   for i=1,colors do
     
     for j=1,4 do
      colors_temp[#colors_temp+1]=math.floor( a_colors[k][j]*255)
      
      imgui.Text(colors_temp[j].." "..i.." "..j.." "..k.." "..a_colors[k][j]*255)
      i=i+1
     end
     imgui.Separator()
     k=k+1
   end
   
   
  
  sizes_temp={}
    
    for i =1, num_sizes do
      sizes_temp[#sizes_temp+1] = sizes[i]
    end
    
  
   
   my_system:setTexture(pictures[act_pic])
   
   my_system:moveTo(val,val2)
   
   my_system:emit(val3)
   my_system:setAreaSpread(spreadDist[cur],distx,disty)
   my_system:setDirection(val4)
   my_system:setEmitterLifetime(life)
   my_system:setEmissionRate(rate)
   
   my_system:setLinearAcceleration(speed.linear[1],speed.linear[2],speed.linear[3],speed.linear[4])
   my_system:setRadialAcceleration(speed.radial[1],speed.radial[2])
   my_system:setTangentialAcceleration(speed.tangent[1],speed.tangent[2])
   my_system:setSpeed(speed.min,speed.max)
   
   
   my_system:setInsertMode(ins_modes[mode])
   my_system:setParticleLifetime(p_life_min,p_life_max)
   
   --my_system:setLinearDamping(0,0)
   
   
   imgui.Text(spread)
   my_system:setSpread(spread)
   my_system:setSizes(unpack(sizes_temp))
   my_system:setSizeVariation(size_diff)
   
   my_system:setColors(unpack(colors_temp))
   
  -- my_system:setBufferSize(20)
   imgui.Render();
   
   if blendM < 7 then
     love.graphics.setBlendMode(blendModes[blendM],alphaBlendMode[blendA])
   else
     blendA=2
     love.graphics.setBlendMode(blendModes[blendM],alphaBlendMode[blendA])
   end
   if s == true then
     my_system:reset()
   end
   love.graphics.draw(my_system)
   love.graphics.setBlendMode(blendModes[1],alphaBlendMode[1])
end

function love.keyreleased(key)
     imgui.KeyReleased(key)
    if not imgui.GetWantCaptureKeyboard() then
        -- Pass event to the game
    end
end

function love.quit()
    imgui.ShutDown();
end



function love.textinput(t)
    imgui.TextInput(t)
    if not imgui.GetWantCaptureKeyboard() then
        -- Pass event to the game
    end
end

function love.keypressed(key)
    imgui.KeyPressed(key)
    if not imgui.GetWantCaptureKeyboard() then
        -- Pass event to the game
    end
end


function love.mousemoved(x, y)
    imgui.MouseMoved(x, y)
    if not imgui.GetWantCaptureMouse() then
        -- Pass event to the game
    end
end

function love.mousepressed(x, y, button)
    imgui.MousePressed(button)
    if not imgui.GetWantCaptureMouse() then
        -- Pass event to the game
    end
end

function love.mousereleased(x, y, button)
    imgui.MouseReleased(button)
    if not imgui.GetWantCaptureMouse() then
        -- Pass event to the game
    end
end

function love.wheelmoved(x, y)
    imgui.WheelMoved(y)
    if not imgui.GetWantCaptureMouse() then
        -- Pass event to the game
    end
end