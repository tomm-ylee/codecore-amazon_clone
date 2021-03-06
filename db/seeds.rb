Tagging.destroy_all
Favourite.destroy_all
Like.destroy_all

Tag.destroy_all
Review.destroy_all
Product.destroy_all
User.destroy_all


PASSWORD = 'tester'
User.create(first_name: 'Admin', last_name: 'User', email: 'admin@email.com', password: PASSWORD, is_admin: true)

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

30.times.each do
  Tag.create(
    name: Faker::Book.genre.downcase
  )
end

tags = Tag.all

puts "Created #{tags.count} tags"

40.times do
  p = Product.create(
    title: Faker::Food.dish,
    description: Faker::Movie.quote,
    price: rand(5..300),
    user: users.sample
  )

  if p.valid?
    3.times do
      hide_it = rand(6) > 5 ? true : false

      Review.create(
        rating: rand(1..5),
        body: Faker::RickAndMorty.quote,
        product: p,
        user: users.sample,
        users: users.shuffle.slice(0..rand(users.count)),
        hidden: hide_it
      )
    end
  end
  p.tags = tags.shuffle.slice(0..rand(5))
  p.users = users.shuffle.slice(0..rand(users.count))

end

puts "Created #{User.count} users"
puts "Seeded #{Product.count} products and #{Review.count} reviews"
