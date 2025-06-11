# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

genres = "Action", "Comedy", "Drama", "Horror"
100.times do
  Movie.create(title: Faker::Movie.title,
               category: genres.sample,
               description: Faker::Lorem.paragraph,
               year: 2020)

end

10.times do
  User.create_with(password: Faker::Internet.password, name: Faker::Name.unique.name)
      .find_or_create_by(email: Faker::Internet.unique.email)
end

User.create_with(name: "Admin", password: "12345678")
    .find_or_create_by(email: "admin@email.com")
