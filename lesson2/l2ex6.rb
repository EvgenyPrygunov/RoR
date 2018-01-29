puts 'If you want to stop - type "stop" instead of the name of the item.'
shopping_cart = Hash.new
value_amount = Hash.new

loop do

  puts 'Hello, input item name.'
  name = gets.chomp.capitalize!
  break if name == 'Stop'
  puts 'Input item value.'
  value = gets.chomp.to_f
  puts 'Input item amount.'
  amount = gets.chomp.to_f

  shopping_cart[name] = value_amount
  value_amount[value] = amount
  value_amount = {}

end

puts shopping_cart

total = 0
summary = 0

shopping_cart.each do |key, value|
  value.each do |k, v|
    total = k * v
    summary += total
  end
  puts "Total price for #{key}: #{total}."
end

puts "Total price for the whole shopping cart is: #{summary}"
