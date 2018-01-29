fibo = [0]

i = 1
while i < 100
  fibo.push(i)
  i += fibo[-2]
end

print fibo
