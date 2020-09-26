RSpec.describe Author, type: :model do
  context 'with validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  context 'with associations' do
    it { is_expected.to have_many(:books) }
    it { is_expected.to have_many(:author_books) }
  end

  context 'with model fields' do
    it { is_expected.to have_db_column(:first_name) }
    it { is_expected.to have_db_column(:last_name) }
  end
end
