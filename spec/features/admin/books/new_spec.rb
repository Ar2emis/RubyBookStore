RSpec.describe 'Show', type: :feature do
  before do
    admin_log_in
  end

  context 'with valid input' do
    let!(:book) { build(:book) }

    before do
      visit new_admin_book_path
      page.select(book.category.name, from: 'book_category_id')
      fill_in('book_title', with: book.title)
      book.authors.map(&:id).each { |id| check("book_author_ids_#{id}") }
      fill_in('book_description', with: book.description)
      fill_in('book_price', with: book.price)
      fill_in('book_height', with: book.height)
      fill_in('book_width', with: book.width)
      fill_in('book_depth', with: book.depth)
      fill_in('book_materials', with: book.materials)
      click_button('commit')
    end

    it 'creates book' do
      expect(page).to have_content('Book was successfully created.')
    end
  end

  context 'with invalid input' do
    before do
      visit new_admin_book_path
      click_button('commit')
    end

    {
      category: 'must exist',
      title: "can't be blank",
      price: "can't be blank and is not a number"
    }.each do |attribute, error|
      it "displays #{attribute} error message" do
        expect(page).to have_content(error)
      end
    end
  end
end
