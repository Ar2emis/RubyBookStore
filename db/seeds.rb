email = 'admin@example.com'
password = 'password'
AdminUser.first_or_create!(email: email) do |admin|
  admin.password = password
  admin.password_confirmation = password
end

(1..3).each do
  DeliveryType.create!(name: Faker::Subscription.plan, min_days: rand(1..3), max_days: rand(5..7), price: rand(1..10))
  category = Category.create!(name: Faker::Book.genre)
  (1..6).each do
    author = Author.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
    book = Book.create!(title: Faker::Book.title, price: 1, category: category, description: Faker::Lorem.paragraph_by_chars, authors: [author])
    book.title_image.attach(io: File.open('app/assets/images/default_book.png'), filename: 'default_book.png', content_type: 'image/png')
    (1..3).each do
      book.images.attach(io: File.open('app/assets/images/default_book.png'), filename: 'default_book.png', content_type: 'image/png')
    end
  end
end
