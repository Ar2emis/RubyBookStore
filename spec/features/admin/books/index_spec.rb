RSpec.describe 'Index', type: :feature do
  let(:books_amount) { 5 }
  let!(:books) { create_list(:book, books_amount) }

  before do
    admin_log_in
    click_link('Books')
  end

  %i[title price authors_names].each do |attribute|
    it "displays book #{attribute}" do
      books.map(&:decorate).map(&attribute).each do |text|
        expect(page).to have_content(text)
      end
    end
  end

  it 'displays book category' do
    books.map { |book| book.category.name }.each do |category|
      expect(page).to have_content(category)
    end
  end

  it 'displays book short description' do
    books.map { |book| short_description(book.description) }.each do |description|
      expect(page).to have_content(description)
    end
  end
end
