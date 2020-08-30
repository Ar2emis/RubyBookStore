if Rails.env.development?
  email = 'admin@example.com'
  password = 'password'
  AdminUser.create!(email: email, password: password, password_confirmation: password) unless AdminUser.exists?(email: email)
  author = Author.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
  category = Category.create!(name: Faker::Book.genre)
  (1..3).each do
    author.books.create!(title: Faker::Book.title, price: 1, category: category, description: Faker::Lorem.paragraph_by_chars)
  end
end