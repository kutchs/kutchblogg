# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

User.destroy_all
Category.destroy_all
Post.destroy_all
Comment.destroy_all

10.times do
  User.create!(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    nickname: Faker::Internet.username(specifier: 3..8)
  )
end


5.times do
  Category.create!(
    name: Faker::Book.genre
  )
end


# Create Posts
users = User.all
categories = Category.all

20.times do
  Post.create!(
    user: users.sample,
    category: categories.sample,
    title: Faker::Book.title,
    content: Faker::Lorem.paragraph(sentence_count: 5),
    url: Faker::Internet.url,
    rating: rand(1.0..5.0).round(1),
    date: Faker::Date.backward(days: 30)
  )
end

# Create Comments
posts = Post.all

50.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    content: Faker::Lorem.sentence(word_count: 100)
  )
end

puts "Seed data created successfully!"
