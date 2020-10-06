require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'with validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price) }
  end

  context 'with associations' do
    it { is_expected.to have_many(:authors) }
    it { is_expected.to have_many(:author_books) }
    it { is_expected.to belong_to(:category) }
  end

  context 'with model fields' do
    it { is_expected.to have_db_column(:title) }
    it { is_expected.to have_db_column(:price) }
    it { is_expected.to have_db_column(:description) }
    it { is_expected.to have_db_column(:publication_year) }
    it { is_expected.to have_db_column(:width) }
    it { is_expected.to have_db_column(:height) }
    it { is_expected.to have_db_column(:depth) }
    it { is_expected.to have_db_column(:material) }
    it { is_expected.to have_db_column(:category_id) }
  end
end
