i=...
f={}
fi_av=0
for j=1,9 do
 s,f[j]=i:gsub(j,9)
 fi_av=fi_av+f[j]
end
lvl = 1
fpl = 4
while true do
  fn=lvl*fpl
  fpate = 0
  for i=1,lvl do
    fpate=fpate+f[i]*i
  end
  if fpate>=fn then
    elvl=lvl
    while fn>0 do
      if f[elvl]>0 and elvl<=fn then
       fn=fn-elvl
       f[elvl]=f[elvl]-1
      else
       elvl=elvl-1
      end
    end
    lvl=lvl+1
  else
    break
  end
end
print(lvl)