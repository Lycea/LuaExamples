--just a small test of what it should do
-- basis from https://github.com/Berserker66/omnitool/blob/master/world.txt


--first some "types"
local types = {}
types.bool = 1    -- 0 or 1 ...
types.byte = 1
types.word = 2
types.dword = 4
types.pstring = 1  --first copy the number and then copy the number of bytes in that number :P
types.float = 4    -- not sure how to convert but will find out I guess
types.double = 8  --- need to check that too
types.rect   = 4x type.dword -- :p 

local header = {
  1 ={type = "dword",name = "version"},
  2 ={type = "pstring",name = "world id"},
  3 ={type = "rect", name ="world bounds"},
  4 =
  ...



}


--width * hight
local tile ={
  ..
    

}

--chests

--items

--signs


--npc
