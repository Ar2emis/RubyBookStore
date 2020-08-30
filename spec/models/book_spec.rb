require 'rails_helper'

RSpec.describe Book, type: :model do
  subject(:book) { build(:book) }

  describe '#authors_names' do
    it 'returns a string with authors full names' do
      expect(book.authors_names).to eq book.authors.map(&:full_name).join(', ')
    end
  end
end
