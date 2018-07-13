







function new_console(buff_size)
  local c = {}

  c.buff = {}
  c.size = buff_size
  c.pos  ={0,0}
  
  function c.log(txt)
    if #c.buff>=c.size then
      table.remove(c.buff,c.size)
    end
    table.insert(c.buff,1,txt)
  end

  function c.draw()
    love.graphics.print(table.concat(c.buff, "\n"),c.pos[1],c.pos[2])
  end

  function c.clear()
    c.buff ={}
  end
  
  function c.setPos(x,y)
      c.pos = {x,y}
  end
  
  
  return c  
end


local c
local inf
local nodes --node names and info about them
local look_node ={}-- lookup table for finding if a node was already "cached"


function love.load()
  c= new_console(10)
  inf = new_console(40)
  inf.setPos(200,0)
end

  
  
local num_nodes = 0
local timer_update = 0
function love.update(dt)
  --get the actuve nodes
  
  
  if timer_update > 0.50 then
    timer_update =0
    love.graphics.print("Collecting information ...",0,500)
    love.graphics.present()
    
    handle=io.popen("rosnode list")
    line = ""
    nodes = {}
    c.clear()
    inf.clear()
    if handle == nil then return end
    while true do
      line = handle:read()
      if line == nil then break end
      c.log(line)
      nodes[#nodes+1] = {}
      nodes[#nodes].name = line
      c.size = #nodes+1
      look_node[line] = true
    end
  
  c.log(#nodes.." active nodes:\n")
  --collect info about these nodes
  
  if num_nodes~= #nodes then
    for i,node in pairs(nodes) do
      if node.name ~= "/rosout" then
        handle=io.popen("rosnode info "..node.name)
        --get output
         nodes[i].info =  handle:read("*a")
        --parse the output ... its far to much and not interesting ...
      end
    end
  end
  num_nodes = #nodes
  end
  timer_update = timer_update +dt
  
end

function love.draw()
c.draw()  
inf.draw()
love.graphics.print(love.timer.getFPS(), 300,0)
end

