require 'rails_helper'

RSpec.describe DeliveryType, type: :model do
  context 'with validations' do
    %i[name min_days max_days price].each do |property|
      it { is_expected.to validate_presence_of(property) }
    end

    %i[min_days max_days price].each do |property|
      it { is_expected.to validate_numericality_of(property).is_greater_than_or_equal_to(0) }
    end
  end

  context 'with model fields' do
    %i[name min_days max_days price].each do |field|
      it { is_expected.to have_db_column(field) }
    end
  end
end
