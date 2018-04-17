
local SLAXML = require 'slaxdom'



local next_level  = 2
local information = 1

local next_level_elems = 1

local ATTR_TEXT = 4

local tree = nil
local level_h = 1
local level_v = 1

function parse_document(doc,space,name)
  if name ~= nil then
    
  end
  for k,v in pairs(doc) do
    if type(v) == "table" then
      print(space..k)
      parse_document(v,space.." ",k)
    else
      print(space..k.." "..v)
    end
  end
end

--find the nodes in the tree
function parse_tree(doc,space,tree_tmp)
  if doc.type == "document" then
    --move one level deeper
    --at one is the description at two the next level
    parse_tree(doc.kids[next_level],space)
    return
  elseif doc.type == "element" then
    --now we have a real element... check it !  
    if doc.name == "map" then
      --nope still one too high
      parse_tree(doc.kids[next_level_elems],space)
    elseif doc.name ~= "node" then
      return -1
    elseif doc.name == "node" then
      --we got a node !! 
      --save the name and check if you can go deeper
        if tree == nil and tree_tmp == nil then
          tree = doc
          
          tree.name = doc.attr[ATTR_TEXT].value
          tree.attr = nil
          tree.num_kids = #tree.kids
  
          for i=1,tree.num_kids do
            --go into the child and continue the routin
            parse_tree(tree.kids[i],spaces,tree.kids[i])
          end
        else
          -- find the name
          for k,v in pairs(tree_tmp.attr) do
            if v.name == "TEXT" then
              tree_tmp.name = v.value
              break
            end
          end
          
          tree_tmp.attr = nil
          tree_tmp.type = nil --use as  something probably later
          tree_tmp.num_kids = #tree_tmp.kids
          
          for i=tree_tmp.num_kids,1,-1 do
            --go into the child and continue the routin
            if parse_tree(tree_tmp.kids[i],spaces,tree_tmp.kids[i]) == -1 then
                table.remove(tree_tmp.kids,i) 
                tree_tmp.num_kids =tree_tmp.num_kids- 1
            end
            
          end
          
        end
    else 
      
        
        
    end
    
  
  end
  
end


local file = io.open("root.xml"):read("*all")
document = SLAXML:dom(file,{simple=true})
--doc =doc.kids[2].kids[1]
parse_document(document,"")
parse_tree(document,"",nil)
print("test")
