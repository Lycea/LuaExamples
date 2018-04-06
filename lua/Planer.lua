local BASE = (...)..'.' 
print(BASE)
local i= BASE:find("Planer.$")
print (i)
BASE=BASE:sub(1,i-1)
print(BASE)

local star = require(BASE.."AStar")

local planer ={}

function planer.CheckReach(map,start_pos)
  local reach_ids = {}
  local frontier = {} --simple table
  local visited = {} --another table
  
  local index = 0
  
  visited:setmetatable(visited,{__index = function(t,key) return false end})
  visited[start_pos.y]={}
  visited[start_pos.y][start_pos.x] = true
  
  frontier[#frontier]= start_pos
  
  while frontier[index+1] do
    local current = frontier[index+1]
    --get the neighbours
    local neighbours = {
        {current.x -1,current.y}, --left
        {current.x +1,current.y}, --right
        {current.x ,current.y +1},-- down
        {current.x ,current.y -1}, --top
      }
    for i,p in pairs(neighbours) do
      if  not visited[p.y] then visited[p.y] = {} end
      if  not visited[p.y][p.x] then
        frontier[#frontier+1] = p
        visited[p.y][p.x] = true
      end
    end
    
    
    index = index+1
  end
  
  
  
end
