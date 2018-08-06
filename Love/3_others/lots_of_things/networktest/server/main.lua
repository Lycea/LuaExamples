sock = require("sock")


local clients ={}
local client_counter = 0
local positions={}
local pos_change = false


-- server.lua
function love.load()
  --require("mobdebug").start()
    -- Creating a server on any IP, port 22122
    server = sock.newServer("*", 22122)
    
    -- Called when someone connects to the server
    server:on("connect", function(data, client)
        -- Send a message back to the connected client
        local msg = "Hello from the server!"
        print("client connected to the server")
        client:send("hello", msg)
        clients[client.connectId] = client
        client_counter= client_counter+1
    end)
  
  server:on("greeting",function(data,client)
      print("Client is greeting: "..data)
      end)
  
    server:on("disconnect",function(data,client)
        print("bye bye?")
        clients[client.connectId]=nil
        client_counter=client_counter-1
      end)
  server:on("changed_position",function(data,client)
      print("Got new position "..data[1].." "..data[2].."|from client "..client.connectId)
      pos_change = true
      data = {data[1],data[2],id=client.connectId}
      positions[client.connectId] = data
      end)
end

function love.draw()
  local txt = ""
   for i,client in pairs(clients) do
     txt = txt.."Client id: "..client.connectId.."\n"
   end
   
   love.graphics.print(txt.."Number connected clients: "..client_counter,0,0)
end


function love.update(dt)
  if pos_change == true then
    server:sendToAll("pos_change",positions)
    pos_change = false
  end
    server:update()
end