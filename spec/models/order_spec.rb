RSpec.describe Order, type: :model do
  context 'with associations' do
    it { is_expected.to belong_to(:user).optional(true) }
    it { is_expected.to have_one(:order_coupon).dependent(:destroy) }
    it { is_expected.to have_one(:coupon).through(:order_coupon) }
    it { is_expected.to have_many(:order_items).dependent(:destroy) }
  end

  context 'with model fields' do
    it { is_expected.to have_db_column(:user_id) }
  end
end
