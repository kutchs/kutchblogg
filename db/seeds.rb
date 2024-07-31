require 'faker'
require 'open-uri'

# Assurez-vous de détruire les enregistrements dans le bon ordre
Comment.destroy_all
Post.destroy_all
Category.destroy_all
User.destroy_all

# Create Users
10.times do
  User.create!(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password',
    nickname: Faker::Internet.username(specifier: 3..8)
  )
end

# Create Categories
5.times do
  Category.create!(
    name: Faker::Book.genre
  )
end

# Create Posts
image_urls = [
  'https://res.cloudinary.com/dqbzdz3ob/image/upload/v1720380985/immeuble-en-bois_a2wxrl.jpg',
  'https://res.cloudinary.com/dqbzdz3ob/image/upload/v1720380984/bois1_zm77a6.jpg',
  'https://res.cloudinary.com/dqbzdz3ob/image/upload/v1720380984/002100346_620x393_c_furund.jpg',
  'https://res.cloudinary.com/dqbzdz3ob/image/upload/v1720380984/135-construction_bois-neel-_2_aqufzy.jpg',
  'https://res.cloudinary.com/dqbzdz3ob/image/upload/v1720380984/camping-local-1_tuaeyt.jpg',
  'https://www.architectes-pour-tous.fr/sites/cnoa/files/styles/annonce_843x561/public/2024-01/field_visuels/42422-ion_maison_bois_dans_le_pilat_-_stephen_mure_architecte_saint-etienne_-habitat_maison_passive_02.png?itok=5W4EThC5',
  'https://www.immo-capferret.com/uploads/villa-architecte-presqu-ile-cap-ferret.png',
  'https://www.archimaison.fr/wp-content/uploads/2022/03/Maison-familiale-Les-avenues-a-Compiegne-Viney-architecte-DPLG-Compiegne-3-1.png',
  'https://www.explore-grandest.com/wp-content/uploads/2021/11/maison-du-hobbit-boldair-michel-laurent-6.jpg',
  'https://static.actu.fr/uploads/2021/08/naturadome-photo-principale-960x640.png',
  'https://i.pinimg.com/originals/87/5b/29/875b298fb0f3c5073646bffe11c175bd.png',
  'https://c8.alamy.com/compfr/cbxa1m/maison-victorienne-le-quartier-des-jardins-la-nouvelle-orleans-cbxa1m.jpg',
  'https://green-house-project.com/wp-content/uploads/2018/03/stunning-design-house-architecture-best-20-house-architecture-ideas-on-pinterest-modern.jpg',
  'https://cdn.pap.fr/image/cms/35/c6/35c6cb56451b8c6a888cf14ce592b64d/3-500x350-s3.jpg',
  'https://static.propassif.fr/media/photos/bias-maison-premium-propassif-labellisation-pasive.lg.jpg',
  'https://www.neozone.org/blog/wp-content/uploads/2020/12/kirimoko-tiny-house-001.jpg'
]

users = User.all
categories = Category.all

20.times do
  post = Post.create!(
    user: users.sample,
    title: Faker::Book.title,
    content: Faker::Lorem.paragraph(sentence_count: 5),
    url: Faker::Internet.url,
    rating: rand(1.0..5.0).round(1),
    date: Faker::Date.backward(days: 30)
  )

  # Associer des catégories
  post.categories << categories.sample(2)

  # Attacher une image avec ActiveStorage et Cloudinary
  image_url = image_urls.sample
  downloaded_image = URI.open(image_url)
  post.photo.attach(io: downloaded_image, filename: File.basename(image_url), content_type: 'image/jpeg')

  post.save
end

# Create Comments
posts = Post.all

50.times do
  Comment.create!(
    user: users.sample,
    post: posts.sample,
    content: Faker::Lorem.sentence(word_count: 10)
  )
end

puts "Seed data created successfully!"

