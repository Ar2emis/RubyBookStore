require 'rails_helper'

RSpec.describe Cart, type: :model do
  context 'with associations' do
    it { is_expected.to belong_to(:user).optional(true) }
    it { is_expected.to have_one(:couponable_coupon).dependent(:destroy) }
    it { is_expected.to have_one(:coupon).through(:couponable_coupon) }
    it { is_expected.to have_many(:cart_items).dependent(:destroy) }
  end

  context 'with model fields' do
    %i[user_id].each do |column|
      it { is_expected.to have_db_column(column) }
    end
  end
end
