require 'rails_helper'

RSpec.describe Cart, type: :model do
  context 'with associations' do
    %i[user coupon].each do |model|
      it { is_expected.to belong_to(model).optional(true) }
    end

    it { is_expected.to have_many(:cart_items).dependent(:destroy) }
  end

  context 'with model fields' do
    %i[user_id coupon_id].each do |column|
      it { is_expected.to have_db_column(column) }
    end
  end
end
