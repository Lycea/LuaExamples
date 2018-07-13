local r = 100  -- radius to look for neighbours
local k = 30 --the tries to add a new point
local grid ={} --grid that holds all
local w = r/math.sqrt(2);  --??
local active ={} --points you search further points from :P
local cols, rows  -- rolumns and rows ... nothing unusual

local scr_w,scr_h

local ordered ={} --points time after time

local function dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

local flr = math.floor

function love.load()
  require("mobdebug").start()
  scr_w,scr_h= love.graphics.getDimensions()
  
  
  --init rows / columns
  cols = flr(scr_w/w)
  rows = flr(scr_h/w)
  
  print(cols*rows)
  --init .. not needed cause lua ?
  --for i=1,cols*rows do
  --    grid[i] = false
  --end
  
  --add the starting position
  local x = scr_w /2
  local y = scr_h/2
  local i = flr(x/w)
  local j = flr(y/w)
  local pos = {x=x,y=y}
  print("test"..i+j*cols)
  grid[i+j*cols] = pos
  table.insert(active,pos)
  
end

function love.draw()
  local runs = 5
  
  --points to add in one go
  for tota = 0, runs do
    --is there an element left to check
    if #active >0 then
      local randIdx = math.random(1,#active) --get a point from the list
      local pos     = active[randIdx] --object
      local found   = false   --if a possible location was found
      
      --as long as passes left
      print("test")
      for n=0,k do
        
        local sample = {}
        sample.angle =  math.rad(math.random(0,360))  --angle of the new point
        sample.m     =  math.random(r,2*r)              --distance of the new point
        
        --now could work ....
        sample.x     = pos.x + math.sin(sample.angle)*sample.m    
        sample.y     = pos.y + math.cos(sample.angle)*sample.m 
        
        local col = flr(sample.x/w)  --col which the sample is in
        local row = flr(sample.y/w)  --row which the sample is in
        
        --is in bounds , then doooo stufff
        if col > -1  and row > -1 and col < cols and row<rows and  grid[col*row*cols] == nil then
          local ok = true -- can be set
          
          --go check neighbours
          for i= -1,1 do
            for j=-1,1 do
              local idx = (col+i)+(row+j)*cols --index in the grid ???
              local nbs = grid[idx]
              if nbs == true then
                local d = dist(sample.x,sample.y,nbs.x,nbs.y)
                if d < r then
                  ok = false
                end
              end -- neighbour check
              
            end--neighbour inner l
          end--neighbour outer l
          
          --no close enough neighbours
          if ok == true then
            found = true  --foud a position
            grid[col+row*cols] = sample
            table.insert(active,sample)
            table.insert(ordered,sample)
            break
          end
        end--end bounds check
      end--end tries loop
      
      if found == false then
          --remove the item cause no possible places
          table.remove(active,randIdx)
      end
      
    end--end active check
  end-- end one round
  
  for i=1, #ordered do
    if ordered[i] == true then
      love.graphics.circle("fill",ordered[i].x,ordered[i].y,2)
    end
  end
  
  for i=1, #active do
    love.graphics.circle("fill",active[i].x,active[i].y,2)
  end
  
  --draw stuff <3
end

