RSpec.describe BasePresenter do
  subject(:presenter) { described_class.new(view: view) }

  let(:view) { ActionView::Base.new }
  let(:book) { build(:book) }
  let(:default_image_name) { 'default_book' }

  it 'returns default book title image url if no image attached' do
    expect(presenter.title_image_url(book)).to match(/#{default_image_name}/)
  end
end
