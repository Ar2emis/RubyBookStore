RSpec.describe Review, type: :model do
  context 'with associations' do
    %i[book user].each do |model|
      it { is_expected.to belong_to(model) }
    end
  end

  context 'with model fields' do
    %i[title body book_rate user_id book_id status].each do |field|
      it { is_expected.to have_db_column(field) }
    end
  end
end
