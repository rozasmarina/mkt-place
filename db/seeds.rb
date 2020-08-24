20.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  username = Faker::Internet.username(specifier: "#{first_name} #{last_name}", separators: %w[. _ -])
  email = Faker::Internet.free_email(name: username)
  encrypted_password = "12345"
  address = Faker::Address.full_address
  phone_number = "0#{rand(1..9)}#{rand(0..9)}9#{rand(2..9)}#{(0..9).to_a.sample(7)}"
  cpf = (0..9).to_a.sample(11).to_s
  User.create!(first_name: first_name,
               last_name: last_name,
               username: username,
               email: email,
               encrypted_password: encrypted_password,
               address: address,
               phone_number: phone_number,
               cpf: cpf)
end

rand(0..8).times do
  product_name = Faker::Commerce.product_name
  product_category = Faker::Commerce.department
  product_description = Faker::TvShows::Simpsons.quote
  price = Faker::Commerce.price
  quantity = rand(1..10)
  type = %w[gallery highlight top free].sample
  Announce.create!(product_name: product_name,
                   product_category: product_category,
                   product_description: product_description,
                   price: price,
                   quantity: quantity,
                   type: type)
end
