require 'rails_helper'

RSpec.describe BookDecorator do
  subject(:decorator) { book.decorate }

  let(:book) { build(:book) }

  describe '#authors_names' do
    it 'returns authors name as string' do
      authors_names = book.authors.map { |author| "#{author.first_name} #{author.last_name}" }.join(', ')
      expect(decorator.authors_names).to eq authors_names
    end
  end
end
