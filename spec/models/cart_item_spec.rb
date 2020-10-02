require 'rails_helper'

RSpec.describe CartItem, type: :model do
  context 'with validations' do
    it { is_expected.to validate_presence_of(:book) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
  end

  context 'with associations' do
    %i[book cart].each do |model|
      it { is_expected.to belong_to(model) }
    end
  end

  context 'with model fields' do
    %i[book_id cart_id amount].each do |column|
      it { is_expected.to have_db_column(column) }
    end
  end
end
