local sock = require "sock"

-- client.lua
local pos_all = {}
local my_pos = {}

function love.load()
  --require("mobdebug").start()
    --create a random position
    scr_w ,scr_h = love.graphics.getDimensions()
    x =love.math.random(0,scr_w -10)
    y =love.math.random(0,scr_h -10)
    table.insert(pos_all,{x,y})
    my_pos={x,y}
    -- Creating a new client on localhost:22122
    client = sock.newClient("localhost", 22122)
    
    -- Creating a client to connect to some ip address
    --client = sock.newClient("198.51.100.0", 22122)

    -- Called when a connection is made to the server
    client:on("connect", function(data)
        print("Client connected to the server.")
    end)
    
    -- Called when the client disconnects from the server
    client:on("disconnect", function(data)
        print("Client disconnected from the server.")
    end)

    -- Custom callback, called whenever you send the event from the server
    client:on("hello", function(msg)
        print("The server replied: " .. msg)
    end)

    client:on("pos_change",function(data)
        pos_all = data
      end)
    client:connect()
    
    while client:isConnected() == false do
      client:update()
    end
    
    client:send("greeting", "Hello, my name is Inigo Montoya.")
end

old_pos = {0,0}

local time = 0
function love.update(dt)
  
  local keys = {"up","down","left","right"}
  local dirs = {up={0,-1},down={0,1},left={-1,0},right={1,0}}
  
  for i,key in pairs(keys) do
    if love.keyboard.isDown(key)== true then
      my_pos = {my_pos[1]+dirs[key][1],my_pos[2]+dirs[key][2]}
    end
  end
  if my_pos[1] ~= old_pos[1] then
    client:send("changed_position",my_pos)
    print("send new position ...")
  elseif my_pos[2] ~= old_pos[2] then
    client:send("changed_position",my_pos)
    print("send new position ...")
  else
   --print(my_pos[1].." "..my_pos[2].." | "..old_pos[1].." "..old_pos[2])
  end
  
  
  
  old_pos = {my_pos[1],my_pos[2]}
  client:update()
end



function love.quit()
    client:disconnectNow()
end


function love.draw()
  
  for i, pos_ in pairs(pos_all) do
    if pos_.id == client:getConnectId() then
      love.graphics.setColor(1,0,0,1)
      love.graphics.rectangle("fill",pos_[1],pos_[2],10,10) 
      love.graphics.setColor(1,1,1,1)
    else
      print(client:getConnectId() ,pos_.id)
      love.graphics.rectangle("fill",pos_[1],pos_[2],10,10) 
    end
  end
  
  --love.graphics.setColor(1,0,0,1)
  --love.graphics.rectangle("fill",my_pos[1],my_pos[2],10,10)  
  --love.graphics.setColor(1,1,1,1)
  love.graphics.print(love.timer.getFPS(),0,0)
end
