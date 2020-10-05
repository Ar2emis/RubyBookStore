RSpec.describe Book, type: :model do
  context 'with validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price) }
  end

  context 'with associations' do
    it { is_expected.to have_many(:authors) }
    it { is_expected.to have_many(:author_books) }
    it { is_expected.to belong_to(:category) }
  end

  context 'with model fields' do
    it { is_expected.to have_db_column(:title) }
    it { is_expected.to have_db_column(:price) }
    it { is_expected.to have_db_column(:description) }
    it { is_expected.to have_db_column(:publication_year) }
    it { is_expected.to have_db_column(:width) }
    it { is_expected.to have_db_column(:height) }
    it { is_expected.to have_db_column(:depth) }
    it { is_expected.to have_db_column(:materials) }
    it { is_expected.to have_db_column(:category_id) }
  end

  describe '.ordered' do
    let(:sort_symbol) { :atoz }
    let(:invalid_sort_symbol) { :invalid_sort }
    let(:books_amount) { 3 }

    before do
      create_list(:book, books_amount)
    end

    it 'sorts by predefined in model sort scopes' do
      sorted_by_title_books = described_class.order(:title).map(&:title)
      expect(described_class.ordered(sort_symbol).map(&:title)).to eq sorted_by_title_books
    end

    it 'sorts by newest if no scope provided in model for passed symbol' do
      sorted_by_title_books = described_class.order(created_at: :desc).map(&:title)
      expect(described_class.ordered(invalid_sort_symbol).map(&:title)).to eq sorted_by_title_books
    end
  end
end
