RSpec.describe Card, type: :model do
  context 'with associations' do
    it { is_expected.to belong_to(:order) }
  end

  context 'with model fields' do
    %i[number name expiration_date cvv order_id].each do |field|
      it { is_expected.to have_db_column(field) }
    end
  end
end
