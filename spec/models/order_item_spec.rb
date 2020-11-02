RSpec.describe OrderItem, type: :model do
  context 'with validations' do
    it { is_expected.to validate_presence_of(:book) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(described_class::MIN_AMOUNT) }
  end

  context 'with associations' do
    %i[book order].each do |model|
      it { is_expected.to belong_to(model) }
    end
  end

  context 'with model fields' do
    %i[book_id order_id quantity].each do |column|
      it { is_expected.to have_db_column(column) }
    end
  end
end
