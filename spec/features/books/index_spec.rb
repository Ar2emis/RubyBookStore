RSpec.describe 'books#index', type: :feature do
  context 'with books filtering' do
    let!(:category) { create(:category) }
    let(:category_books_amount) { 3 }
    let!(:category_books) { create_list(:book, category_books_amount, category: category) }
    let(:other_books_amount) { 3 }
    let!(:other_books) { create_list(:book, other_books_amount) }

    before do
      visit books_path
    end

    it 'displays all books' do
      (category_books + other_books).each do |book|
        expect(page).to have_content(book.title)
      end
    end

    context 'with category selected' do
      before do
        within('ul.list-inline.pt-10.mb-25.mr-240') { click_link(category.name) }
      end

      it 'displays only category books' do
        category_books.each do |book|
          expect(page).to have_content(book.title)
        end
      end

      it "does't display others books" do
        other_books.each do |book|
          expect(page).not_to have_content(book.title)
        end
      end
    end
  end

  context 'with sorting' do
    let(:books_amount) { 10 }
    let!(:books) { create_list(:book, books_amount) }

    before do
      visit books_path
    end

    it 'displays newest books first' do
      books_titles = books.sort_by(&:created_at).map(&:title)
      displayed_titles = page.all('p.title').map(&:text)
      expect(books_titles).to eq displayed_titles
    end

    {
      I18n.t('books.sort.cheap') => :price,
      I18n.t('books.sort.atoz') => :title,
      I18n.t('books.sort.expensive') => { price: :desc },
      I18n.t('books.sort.ztoa') => { title: :desc }
    }.each do |sort_name, property|
      it "displays books sorted by '#{sort_name}}'" do
        within('.hidden-xs.clearfix') { click_link(sort_name) }
        books_titles = Book.order(property).limit(books_amount).map(&:title)
        displayed_titles = page.all('p.title').map(&:text)
        expect(books_titles).to eq displayed_titles
      end
    end
  end

  context 'with view more button' do
    let(:books_amount) { 20 }
    let(:view_more_button) { I18n.t('books.view_more') }

    before do
      create_list(:book, books_amount)
      visit books_path
    end

    it 'displays View more button if not all books displayed' do
      expect(page).to have_content(view_more_button)
    end

    it 'disables View more button if all books displayed' do
      click_link(view_more_button)
      expect(page).not_to have_selector('span#next_link', text: I18n.t('books.view_more'))
    end
  end
end
