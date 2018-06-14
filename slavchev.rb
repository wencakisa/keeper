require './config'

User.insert DATABASE, User.new('Julion', 17)

puts 'All Users:'
result = User.all DATABASE

result.each do |row|
  puts row.join ', '
end