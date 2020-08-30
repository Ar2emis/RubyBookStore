require 'rails_helper'

RSpec.describe Author, type: :model do
  subject(:author) { build(:author) }

  describe '#full_name' do
    it 'returns first and last names' do
      expect(author.full_name).to eq "#{author.first_name} #{author.last_name}"
    end
  end
end
