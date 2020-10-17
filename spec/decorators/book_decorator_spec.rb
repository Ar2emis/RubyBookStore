RSpec.describe BookDecorator do
  subject(:decorator) { book.decorate }

  let(:book) { create(:book) }

  describe '#authors_names' do
    it 'returns authors names as string' do
      authors_names = book.authors.decorate.map(&:full_name).join(', ')
      expect(decorator.authors_names).to eq authors_names
    end
  end
end
