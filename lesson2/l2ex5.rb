puts 'Hello, input day number.'
day = gets.chomp.to_i
puts 'Input month number.'
month = gets.chomp.to_i
puts 'Input year.'
year = gets.chomp.to_i

months = { 1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31 }

if (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)
  months[2] = 29
end

month_sum = 0

months.each do |k, v|
  break if k == month
  month_sum += v
end

date_num = month_sum + day

puts "Date number is #{date_num}."
