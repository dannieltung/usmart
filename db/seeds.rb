# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Starting to seed!'

a = 3
b = 3
a.times do
  Payment.create(amount: 1.50,
                 date: "31/12/2020",
                 due_date: "31/12/2020",
                 partial: b,
                 total_partial: a,
                 description: "abc",
                 user_id: 1,
                 credit_card_id: 1,
                 buyer_id: 1,
                 category_id: 1)
  b -= 1
end

puts 'Seeded with success!'
