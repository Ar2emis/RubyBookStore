RSpec.describe 'Index', type: :feature do
  let(:authors_amount) { 5 }
  let!(:authors) { create_list(:author, authors_amount) }

  before do
    admin_log_in
    click_link('Authors')
  end

  %i[first_name last_name].each do |attribute|
    it "displays author's #{attribute}" do
      authors.map(&attribute).each do |text|
        expect(page).to have_content(text)
      end
    end
  end

  it "displays author's short description" do
    authors.map { |author| short_description(author.description) }.each do |description|
      expect(page).to have_content(description)
    end
  end
end
