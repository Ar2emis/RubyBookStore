RSpec.describe BookPresenter do
  subject(:presenter) { described_class.new(view: fake_view, book: book) }

  let(:book) { build(:book) }

  describe '#description_long?' do
    subject(:short_description_presenter) { described_class.new(view: fake_view, book: short_book) }

    let(:short_book) { build(:book, description: '') }

    it "returns true if description longer than #{described_class::SHORT_DESCRIPTION_MAX_LENGTH}" do
      expect(presenter).to be_description_long
    end

    it "returns false if description shorter than #{described_class::SHORT_DESCRIPTION_MAX_LENGTH + 1}" do
      expect(short_description_presenter).not_to be_description_long
    end
  end

  describe '#short_description' do
    it 'returns truncated description' do
      short_description = "#{book.description[0...(described_class::SHORT_DESCRIPTION_MAX_LENGTH - 3)]}..."
      expect(presenter.short_description).to eq short_description
    end
  end
end
