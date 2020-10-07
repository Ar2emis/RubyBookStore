RSpec.describe Category, type: :model do
  context 'with validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  context 'with associations' do
    it { is_expected.to have_many(:books) }
  end

  context 'with model fields' do
    it { is_expected.to have_db_column(:name) }
  end
end
