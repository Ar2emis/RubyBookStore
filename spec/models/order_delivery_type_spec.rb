require 'rails_helper'

RSpec.describe OrderDeliveryType, type: :model do
  context 'with associations' do
    %i[order delivery_type].each do |model|
      it { is_expected.to belong_to(model) }
    end
  end

  context 'with model fields' do
    %i[order_id delivery_type_id].each do |column|
      it { is_expected.to have_db_column(column) }
    end
  end
end
