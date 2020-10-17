RSpec.describe Address, type: :model do
  context 'with associations' do
    it { is_expected.to belong_to(:user) }
  end

  context 'with model fields' do
    %i[first_name last_name city country zip address phone user_id address_type].each do |field|
      it { is_expected.to have_db_column(field) }
    end
  end
end
