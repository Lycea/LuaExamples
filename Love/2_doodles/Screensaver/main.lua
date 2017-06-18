local counter = 0
local inactive = false
local pointarray = {}
local idx = 1
local shader 
local canvas



function love.load()
  if arg and arg[#arg] == "-debug" then require("mobdebug").start() end
  width = love.graphics.getWidth()
  height = love.graphics.getHeight()
  --canvas = love.graphics.newCanvas(width,height)
  --ove.graphics.setCanvas(canvas)
      shader = love.graphics.newShader("shaders/light.glsl")
  math.randomseed(os.time())
  
  love.graphics.setBackgroundColor(255,255,255,255)
  
end


function love.draw()
  
  if inactive == true then

    
    love.graphics.setLineWidth(3)
        love.graphics.setShader(shader)
        
          love.graphics.line(pointarray)
          love.graphics.rectangle("fill",0,0,100,100)
         --love.graphics.line(love.math.newBezierCurve(pointarray):render())
        love.graphics.setShader() 

  end

end




function love.update(dt)
  counter = counter + dt
  if inactive == true then
   -- shader:send("mouse",{love.mouse.getX() ,love.mouse.getY()})
    
    local n1 = math.random(0,height)
    local n2 = math.random(0,width)
    
    table.insert(pointarray,#pointarray,n1)
    table.insert(pointarray,#pointarray,n2)
    
    if counter > 2.7 then
      table.remove(pointarray,1)
      table.remove(pointarray,1)
    end
      
    return
  end
  
  if counter > 2 then
    
    love.window.setMode(400,200,{borderless = false})
    width = 200
    height = 200 
    inactive = true
    pointarray = {}
    shader = love.graphics.newShader("shaders/light.glsl")
    for _= 1, 4 do
      if _%2 then
         n1 = math.random(0,width)
      else
         n1 = math.random(0,width)
      end
      table.insert(pointarray,idx,n1)

      idx = idx + 1
    end
  end
end

function love.keypressed()
  idx = 1
  counter = 0
  inactive = false
  pointarray = nil
  love.window.setMode(1,1,{borderless = false})
end


