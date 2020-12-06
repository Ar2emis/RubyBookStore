RSpec.describe Coupon, type: :model do
  context 'with validations' do
    %i[name sale code].each do |property|
      it { is_expected.to validate_presence_of(property) }
    end

    it { is_expected.to validate_numericality_of(:sale).is_greater_than_or_equal_to(described_class::MIN_SALE) }
  end

  context 'with model fields' do
    %i[name sale code].each do |column|
      it { is_expected.to have_db_column(column) }
    end
  end
end
