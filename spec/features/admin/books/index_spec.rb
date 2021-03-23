RSpec.describe 'Index', type: :feature do
  let(:current_page) { Admin::Books::IndexPage.new }
  let(:books_amount) { 5 }
  let!(:books) { create_list(:book, books_amount) }

  before do
    admin_log_in
    current_page.load
  end

  %i[title price authors_names].each do |attribute|
    it "displays book #{attribute}" do
      books.map(&:decorate).map(&attribute).each do |text|
        expect(current_page.table.body).to have_content(text)
      end
    end
  end

  it 'displays book category' do
    books.map { |book| book.category.name }.each do |category|
      expect(current_page.table.body).to have_content(category)
    end
  end

  it 'displays book short description' do
    books.map { |book| short_description(book.description) }.each do |description|
      expect(current_page.table.body).to have_content(description)
    end
  end

  describe 'batch delete' do
    before do
      current_page.table.body.rows.each { |row| row.checkbox.click }
      current_page.batch_actions.click_on
      current_page.batch_actions.delete_selected.click
      current_page.popup.ok.click
    end

    it 'deletes selected books' do
      expect(current_page).not_to have_table
    end
  end
end
