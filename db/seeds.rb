puts "Creating users..."
sleep(1)

25.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  username = Faker::Internet.username(specifier: "#{first_name} #{last_name}", separators: %w[. _ -])
  email = Faker::Internet.free_email(name: username)
  password = "123456"
  address = Faker::Address.full_address
  phone_number = "#{rand(1..9)}#{rand(0..9)}9#{rand(2..9)}#{(0..9).to_a.sample(7).join}"
  cpf = rand.to_s[2..12]
  User.create!(first_name: first_name,
               last_name: last_name,
               username: username,
               email: email,
               password: password,
               address: address,
               phone_number: phone_number,
               cpf: cpf)
end

puts "Creating users with announces..."
sleep(1)

25.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  username = Faker::Internet.username(specifier: "#{first_name} #{last_name}", separators: %w[. _ -])
  email = Faker::Internet.free_email(name: username)
  password = "123456"
  address = Faker::Address.full_address
  phone_number = "#{rand(1..9)}#{rand(0..9)}9#{rand(2..9)}#{(0..9).to_a.sample(7).join}"
  cpf = rand.to_s[2..12]
  user = User.create!(first_name: first_name,
                      last_name: last_name,
                      username: username,
                      email: email,
                      password: password,
                      address: address,
                      phone_number: phone_number,
                      cpf: cpf)
  rand(3..10).times do
    product_name = Faker::Commerce.product_name
    product_category = Faker::Commerce.department
    product_description = Faker::Lorem.paragraphs.join.to_s
    price = Faker::Commerce.price
    quantity = rand(1..10)
    announce_type = %w[Gallery Top Free].sample.to_s
    Announce.create!(product_name: product_name,
                     product_category: product_category,
                     product_description: product_description,
                     price: price,
                     quantity: quantity,
                     announce_type: announce_type,
                     user: user)
  end
end

puts "Generating order..."
rand(20..50).times do
  announce = Announce.find(rand(1..Announce.count))
  buyer = User.find(rand(1..User.count))
  price = rand(20.0..200.0).round(2)
  quantity = rand(1..announce.quantity)
  Order.create!(
    price: price,
    quantity: quantity,
    user: buyer,
    announce: announce
  )
end

puts "Seed successfully created!!!!"
