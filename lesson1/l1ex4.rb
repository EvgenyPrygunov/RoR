puts "Задай первый коэффициент."
a = gets.chomp.to_i
puts "Задай второй коэффициент."
b = gets.chomp.to_i
puts "Задай третий коэффициент."
c = gets.chomp.to_i

d = b*b - 4*a*c

if d > 0
  puts "#{d} - дискриминант. Корни: x1 = #{(-b + Math.sqrt(d))/(2*a)}, x2 = #{(-b - Math.sqrt(d))/(2*a)}."
elsif d == 0
  puts "#{d} - дискриминант. Корень: x = #{-b/(2*a)}."
elsif d < 0
  puts "#{d} - дискриминант. Корней нет."
end