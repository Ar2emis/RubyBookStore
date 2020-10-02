require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  context 'with associations' do
    %i[book order].each do |model|
      it { is_expected.to belong_to(model) }
    end
  end

  context 'with model fields' do
    %i[book_id amount order_id].each do |column|
      it { is_expected.to have_db_column(column) }
    end
  end
end
