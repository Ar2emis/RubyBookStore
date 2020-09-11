RSpec.describe 'books#show', type: :feature do
  let(:book) { create(:book) }

  before do
    visit book_path(book)
  end

  it 'displays book title' do
    expect(page).to have_content(book.title)
  end

  it 'displays book description' do
    expect(page).to have_content(book.description)
  end

  it 'displays book authors' do
    expect(page).to have_content(book.decorate.authors_names)
  end
end
