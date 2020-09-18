RSpec.describe 'Show', type: :feature do
  let(:book) { create(:book) }

  before do
    admin_log_in
    visit admin_book_path(book)
  end

  %i[title price authors_names description publication_year width height depth materials].each do |attribute|
    it "displays book #{attribute}" do
      text = book.decorate.public_send(attribute)
      expect(page).to have_content(text)
    end
  end
end
