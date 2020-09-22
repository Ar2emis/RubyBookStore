RSpec.describe Book, type: :model do
  context 'with validations' do
    %i[title price].each do |property|
      it { is_expected.to validate_presence_of(property) }
    end

    it { is_expected.to validate_numericality_of(:price) }
  end

  context 'with associations' do
    %i[authors author_books reviews].each do |models|
      it { is_expected.to have_many(models) }
    end

    it { is_expected.to belong_to(:category) }

    it { is_expected.to have_one_attached(:title_image) }
    it { is_expected.to have_many_attached(:images) }
  end

  context 'with model fields' do
    %i[title price description publication_year width height depth materials category_id].each do |field|
      it { is_expected.to have_db_column(field) }
    end
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

    it "doesn't sort if no scope provided in model for passed symbol" do
      sorted_by_title_books = described_class.all.map(&:title)
      expect(described_class.ordered(invalid_sort_symbol).map(&:title)).to eq sorted_by_title_books
    end
  end
end
