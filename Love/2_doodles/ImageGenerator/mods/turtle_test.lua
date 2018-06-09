local mod = {}
mod.name ="fractal_test"

local turtle = {}
local node={}
local gr = love.graphics

turtle.start ={
  x = 400,
  y = 400,
  rot = 180
}

local depth = 1
local step = 5
local left =  -30
local right = 30

local actual_pos = 
{
  x = 0,
  y = 0
  }

local actual_rot = 1

turtle["-"] =
function  ()
  --print("left")
  actual_rot = actual_rot +left
  --print(actual_rot)
end

turtle["+"] =
function  ()
  --print("right")
  actual_rot = actual_rot +right
  --print(actual_rot)
end

turtle["f"] =
function  ()
  --print("fw")
  --print(actual_rot)
  local new_x = (step/depth)*math.sin( math.rad(actual_rot))+ actual_pos.x
  local new_y = (step/depth)*math.cos( math.rad(actual_rot))+ actual_pos.y
  
  
  gr.line(actual_pos.x,actual_pos.y,new_x,new_y)
  
  actual_pos.x = new_x
  actual_pos.y = new_y
end


local comm  = "f"
local timer = 0

function mod.draw()
  local idx = 1
  
  actual_rot = turtle.start.rot
  actual_pos = {x = turtle.start.x, y = turtle.start.y}
  --depth = 1
  print("-----")
  while string.len(comm)>= idx do
    --print(string.match(comm,"(.)",idx))
   turtle[string.match(comm,"(.)",idx)]()
   idx = idx +1
  end
  print("-----")

  
end


-- f -> f+
-- + = +-
-- - = -f

local creator = {}

--koch kurve
creator[1] = function ()
  
end


function mod.update(dt)
  --create the list of commands
  if timer < 2 then
    timer = timer +dt
    return
  end
  
  timer = 0
  local comm_n =""
  local comm_r = comm
  while comm_r do
    local letter =comm_r:match("(.)")
    
    if letter == "f" then
     -- comm_n = comm_n.."f+"
      comm_n = comm_n.."f+f-f-f+f"
    elseif letter == "-" then
      --comm_n = comm_n.."-f"
      comm_n = comm_n.."-"
    elseif letter == "+" then
      --comm_n = comm_n.."+-"
      comm_n = comm_n.."+"
    end
    
     comm_r =  comm_r:match(".(.+)")
     --print(comm_r)
  end
  comm = comm_n
  depth = depth +1
  print(comm)
end


function mod.ini()
  
end

function mod.reload()
  
end


function mod.unload()
  
end

return mod