i=...  -- fish input
--check how much of each fish is in the array
print("-----")
print("fish string: "..i)
f={}

fi_av = 0
for j=1,9 do
 s,f[j]=  i:gsub(j,0)
 fi_av=fi_av+f[j]
end
--now we got counter and can grow the fish ;)
print("fishes in the see: "..fi_av)

lvl = 1
fpl = 4
print("-----")

while true do
  fn = lvl*fpl --fish needed
  --check eatable fish
  fate = 0 --fish available to eat
  fpate = 0 -- fish points available to eat
  for i=1,lvl do
    fate  = fate + f[i]
    fpate = fpate + f[i]*i
  end
  
  print("fishes same or smaler: "..fate)
  print("points from these fishes: "..fpate)
  print("points needed: "..fn)
  print("----")
  
  --eat fish till points filled than continue
  --start with the bigger ones first
  if fpate >= fn then
    elvl = lvl --eating level
    while fn > 0 do
      --there is fish on this level and is not waste
      if f[elvl] >0 and elvl <= fn then
       --eat it
       fn = fn - elvl
       f[elvl] = f[elvl]-1
       print("eat lvl "..elvl.." fish")
      else
       --go down a level
       elvl = elvl -1
       print("no lvl "..elvl+1 .." fish. Go to lvl "..elvl.." fish to eat")
      end
    end
    print("level up")
    lvl = lvl+1
  else
    break
  end
  
end

print("fish lvl: "..lvl)



