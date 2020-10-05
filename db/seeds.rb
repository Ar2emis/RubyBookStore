email = 'admin@example.com'
password = 'password'
AdminUser.first_or_create!(email: email) do |admin|
  admin.password = password
  admin.password_confirmation = password
end

(1..3).each do
  category = Category.create!(name: Faker::Book.genre)
  (1..20).each do
    author1 = Author.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
    author2 = Author.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
    Book.create!(title: Faker::Book.title, price: 1, category: category, description: Faker::Lorem.paragraph_by_chars, authors: [author1, author2])
  end
end
