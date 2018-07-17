
local disc ={} --module init

local default_options =
{
  r = 5,-- radius to look for neighbours
  k = 10, --the tries to add a new point
  scr_w = 400,  --field width
  scr_h = 400,  --field height
  num_points = 9999999999, --set to imense high number when not set
  runs_per_call = 10,
  run_till_end  = false
}

--rows / arrays as variables
local grid ={} --grid that holds all
local ordered ={} --points time after time
local active ={} --points you search further points from :P
local cols, rows  -- rolumns and rows ... nothing unusual

local options_run 

local function dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end
local flr = math.floor


function disc.new_points(options)
    options_run ={}
    --set the default settings
    for idx,value in pairs(default_options) do
        options_run[idx] = value
    end

    --overwrite default settings if some are set
    for idx,value in pairs(options) do
        options_run[idx] = value
    end

    options_run.w =options_run.r/math.sqrt(2)  --?? size of a cell
    
    --reset all tables
    grid ={}
    ordered ={}
    active ={}
    
  
    --init rows / columns
    cols = flr(options_run.scr_w/options_run.w)
    rows = flr(options_run.scr_h/options_run.w)
  

  
  --add the starting position
  local x = love.math.random(1,options_run.scr_w-1)--scr_w /2
  local y = love.math.random(1,options_run.scr_h-1)--scr_h/2
  local i = flr(x/options_run.w)
  local j = flr(y/options_run.w)
  local pos = {x=x,y=y}
  --print("test"..i+j*cols)
  grid[i+j*cols] = pos
  pos.count = 0
  table.insert(active,pos)
  
  
end


function disc.run()
  
  --points to add in one go
  local total = 0
  while #active >0 and total <options_run.runs_per_call   do
      total = total+1
      
    --is there an element left to check
    if #active >0  and #ordered< options_run.num_points then
      local randIdx = math.random(1,#active) --get a point from the list
      local pos     = active[randIdx] --object
      local found   = false   --if a possible location was found
      
      --as long as passes left
      for n=0,options_run.k do
        
        local sample = {}
        sample.angle =  math.rad(math.random(0,360))  --angle of the new point
        sample.m     =  math.random(options_run.r,2*options_run.r)              --distance of the new point
        
        --now could work ....
        sample.x     = pos.x + math.sin(sample.angle)*sample.m    
        sample.y     = pos.y + math.cos(sample.angle)*sample.m 
        
        local col = flr(sample.x/options_run.w)  --col which the sample is in
        local row = flr(sample.y/options_run.w)  --row which the sample is in
        
        --is in bounds , then doooo stufff
        if col > -1  and row > -1 and col < cols and row<rows and  grid[col+row*cols] == nil then
          local ok = true -- can be set
          
          --go check neighbours
          for i= -1,1 do
            for j=-1,1 do
              local idx = (col+i)+(row+j)*cols --index in the grid ???
              local nbs = grid[idx]
              if nbs ~=nil then
                local d = dist(sample.x,sample.y,nbs.x,nbs.y)
                if d < options_run.r then
                  ok = false
                end
              end -- neighbour check
              
            end--neighbour inner l
          end--neighbour outer l
          
          --no close enough neighbours
          if ok == true then
            found = true  --foud a position
            grid[col+row*cols] = sample
            sample.count = 0
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
end

function disc.draw()
  
  
  for i=1, #ordered do
    if ordered[i] ~= nil then
      love.graphics.circle("fill",ordered[i].x,ordered[i].y,2)
      
    end
  end
  
  
  for i=1, #active do
      love.graphics.setColor(255,0,active[i].count,255)
    love.graphics.circle("fill",active[i].x,active[i].y,2)
    active[i].count = active[i].count +1
  end
  love.graphics.setColor(0xff,0xff,0xff,255)
  --draw stuff <3
  --print(#active.." "..#ordered)
  love.graphics.setColor(0,0,0,150)
  love.graphics.rectangle("fill",0,0,200,100)
  love.graphics.setColor(0xff,0xff,0xff,255)
  love.graphics.print("FPS_COUNT: "..love.timer.getFPS().."\nSamples: "..#ordered,0,0)
end
--return the module and also the options for interested peeps :P
return disc,default_options
