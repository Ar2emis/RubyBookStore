RSpec.describe 'Index', type: :feature do
  let(:categories_amount) { 5 }
  let!(:categories) { create_list(:category, categories_amount) }

  before do
    admin_log_in
    click_link('Categories')
  end

  it 'displays category name' do
    categories.map(&:name).each do |name|
      expect(page).to have_content(name)
    end
  end
end
