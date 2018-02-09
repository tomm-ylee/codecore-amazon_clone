# Product.destroy_all
#
# 20.times do
#   Product.create(
#     title: Faker::Simpsons.location,
#     description: Faker::Seinfeld.quote,
#     price: rand(1..100)
#   )
# end
#
# puts "Seeded #{Product.count}"

User.destroy_all

10.times do
  User.create(
    first_name: Faker::FamilyGuy.character,
    last_name: Faker::FamilyGuy.character,
    email: Faker::Internet.email
  )
end

puts "Seeded #{User.count}"
