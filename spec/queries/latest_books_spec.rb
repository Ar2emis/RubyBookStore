RSpec.describe LatestBooks do
  let(:amount) { 3 }
  let(:old_book) { create(:book, created_at: 'Wed, 02 Sep 2020 09:01:00') }

  before do
    create_list(:book, amount, created_at: 'Wed, 03 Sep 2020 09:01:00')
  end

  describe '.query' do
    it 'returns latest added books' do
      books = described_class.query(amount)
      expect(books).not_to include(old_book)
    end
  end
end
