email = 'admin@example.com'
password = 'password'
AdminUser.create!(email: email, password: password, password_confirmation: password) unless AdminUser.exists?(email: email)
authors = Array.new(8) { Author.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name) }
categories = Array.new(3) { Category.create!(name: Faker::Book.genre) }
(0...30).each do |number|
  author_one = authors[number % authors.count]
  author_two = authors[number % authors.count]
  category = categories[number % categories.count]
  Book.create!(title: Faker::Book.title, price: Faker::Number.within(range: 1..10), category: category, description: Faker::Lorem.paragraph_by_chars, authors: [author_one, author_two])
end
