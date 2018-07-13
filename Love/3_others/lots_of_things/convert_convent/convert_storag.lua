function f(i)c,a=0,"KMG"
    while i>999 do
        i= i/1024
        c=c+1
    end
    i= i%1==0 and i or string.format("%.2f",i)
    print(c>0 and i..a:sub(c,1).."iB"or i.."B")
end

function g(i)c,a=0,"KMG"
    while i>999 do
        c,i=c+1,i/1024
    end
    i=i%1==0 and i or("").format("%.2f",i)
    print(c>0 and i..a:sub(c,1).."iB"or i.."B")
end

function j(i)c,a=0,"KMG"
    while i>999 do
        c,i=c+1,i/1024
    end
    i=i%1==0 and i or("").format("%.2f",i)
    print(c>0 and i..a:sub(c,1).."iB"or i.."B")
end

function k(i)c,a=0,"KMG"
    while i>999 do
        c,i=c+1,i/1024
    end
    print((i%1==0 and i or("").format("%.2f",i))..(c>0 and a:sub(c,1).."i"or"").."B")
end

function l(i)c,a=0,"KMG"
    while i>999 do
        c,i=c+1,i/1024
    end
    io.write(i%1==0 and i or("").format("%.2f",i),c>0 and a:sub(c,c).."i"or"","B\n")
end

function o(i)c,a=0,"KMG"
    while i>999 do
        c,i=c+1,i/1024
    end
    io.write(math.floor((i+0.005)*100)/100,c>0 and a:sub(c,c).."i"or"","B\n")
end

function n(i)c,a=0,"KMG"while i>999 do c,i=c+1,i/1024 end io.write(i%1==0 and i or("").format("%.2f",i),c>0 and a:sub(c,c).."i"or"","B\n")end


h=loadstring'i,c,a=...,0,"KMG"while i>999 do i=i/1024 c=c+1 end i=i%1==0 and i or("").format("%.2f",i)print(c>0 and i..a:sub(c,c).."iB"or i.."B")'
nums = 
{
  0,1,42,999,1000,1024,2018,100010,456789,20080705,954437177 ,1084587701,1207959551,2147483647 
  }

for _,num in ipairs(nums)do
--l(num) 
io.write(num,"->")
l(num)

--print("--------")
end
