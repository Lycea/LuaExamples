d=table.concat
e=table.insert
n={}
for i=1,9 do
  n[i]=i
end
n[10]=0

t={}
c=1
while c<10 do
s=d(n,string.rep(" ",#n-c-1))
e(t,c,s)
if c==9 then break end
e(t,c,s)
c=c+1
end
print(d(t,"\n"))
