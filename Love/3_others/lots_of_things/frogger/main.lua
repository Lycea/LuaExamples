--up , left,right
dirs = 
{
  {0,-1,"up"},
  {0,1,"down"},
  {-1,0,"left"},
  {1,0,"right"}
}
--objects /cars/stems/turtles
objects =
{
--lanes
}
pos = {}
field = 30


rect = love.graphics.rectangle
dcol = love.graphics.setColor
bcol = love.graphics.setBackgroundColor
txt = ""

function love.load()
  --set player at random pos
  pos.x = field*5
  pos.y = field*12
  pos.w = field-8
  pos.h = field-8
  
  for i=1,20 do
      objects[i] ={}
  end
  
  
  objects[3] = 
  {
    {
      x=0,
      y= (3-1)*field,
      w= 3*field,
      h= field,
      name= "branch",
      speed = -0.1
    }
  }
end




function dist(x,y)
  return math.sqrt(math.pow((x-y),2))
end

move_time = 0

--check if o1 is on o2
function check_on(o1,o2)
  --turn them around cause one is longer then the other
  if o1.w>o2.w then
    o1,o2=o2,o1
  end
  
  if o1.x>= o2.x and o1.x+o1.w<= o2.x+o2.w then
    return true
  else
    return false
  end
end




local checked_obj = 0

function love.update(dt)
  local update ={}
  

  
  --check keys /player move  /left right up down defined
  if move_time > 0.2 then
    for i,dir in ipairs(dirs) do
      if love.keyboard.isDown(dir[3])==true then pos.x=pos.x+field*dir[1]pos.y=pos.y+field*dir[2]move_time=0 break end 
    end
  end
  move_time = move_time+dt
  
 -- check obstacles if player is on something
  local plyr_on_sth = false
  for i,o in pairs(objects[(pos.y/field)+1])do
    if pos.y/field+1 <7  and (pos.y/field)+1~=1  then
      print(check_on(pos,o) and "on "or "of")
      
      if check_on(pos,o) == true then
        pos.x = pos.x +o.speed
      end
    else
      --is on the street check if it is crashing it :P
      if pos.y/field+1 >7 and pos.y/field+1 < 12 then
        
      end
    end
    
  end
  checked_obj = 0
  --update obstacles
  for lane,o_list in pairs(objects) do
    --update all
    for i=#o_list,1,-1 do
      checked_obj = checked_obj +1
      o_list[i].x =o_list[i].x +o_list[i].speed 
      if o_list[i].x +o_list[i].w <=0 then
        --remove
          o_list[i].x= field*8
        --table.remove(o_list,i)
      end
    end
  
end
--check bounds
 if dist(pos.y/field+1,7)> 6  or dist(pos.x/field+1,6)>5 then
    txt = "dead"  
 else
    txt = "key"
 end
 
 
end

  
  


function draw_street()
    love.graphics.setColor(0.25,0.25,0.25,1)
    love.graphics.rectangle("fill",0,7*field,11*field,5*field)
end

function draw_water()
    love.graphics.setColor(0,0,1,1)
    love.graphics.rectangle("fill",0,0,11*field,6*field)
end


function draw_objects()
  local draw = {}
  function draw.branch(o)dcol(0.5,0,0,1)rect("fill",o.x,o.y,o.w,o.h)end
  
  
  for lane,list in pairs(objects) do
    for idx ,obj in pairs(list) do
     -- print(lane,obj.name)
      draw[obj.name](obj)
    end
  end
end

function draw_player()
  love.graphics.setColor(0,0.75,0,1)
  love.graphics.rectangle("fill",pos.x+4,pos.y+4,field-8,field-8)
end

function draw_frogs()
  
end


function love.draw()
  draw_street()
  draw_water()
  draw_objects()
  draw_player()
  draw_frogs()
  
  love.graphics.print(pos.y/field+1, 200,0)
  love.graphics.print(dist(pos.y/field+1,7).." "..dist(pos.x/field+1,6),200,20)
  love.graphics.print(checked_obj,200,40)
  love.graphics.print(love.timer.getFPS(),200,60)
  love.graphics.print(txt,200,80)
end

