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

# User.destroy_all
#
# 10.times do
#   User.create(
#     first_name: Faker::FamilyGuy.character,
#     last_name: Faker::FamilyGuy.character,
#     email: Faker::Internet.email
#   )
# end
#
# puts "Seeded #{User.count}"

Review.destroy_all
Product.destroy_all
User.destroy_all

PASSWORD = 'mypassword'
User.create(first_name: 'Okay', last_name: 'User', email: 'johndoe@email.com', password: PASSWORD)

10.times do

  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  u = User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name}.#{last_name}@example.com",
    password: PASSWORD
  )

  puts u.errors.full_messages
end

users = User.all
40.times do
  p = Product.create(
    title: Faker::Food.dish,
    description: Faker::Movie.quote,
    price: rand(5..300),
    user: users.sample
  )

  if p.valid?
    3.times do
      Review.create(
        rating: rand(1..5),
        body: Faker::RickAndMorty.quote,
        product: p,
        user: users.sample
      )
    end
  end
end

puts "Created #{User.count} users"
puts "Seeded #{Product.count} products and #{Review.count} reviews"
