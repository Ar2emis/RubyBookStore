RSpec.describe Review, type: :model do
  context 'with validations' do
    %i[title body book_id book_rate].each do |property|
      it { is_expected.to validate_presence_of(property) }
    end

    { title: Review::TITLE_MAX_LENGTH, body: Review::BODY_MAX_LENGTH }.each do |property, max_length|
      it { is_expected.to validate_length_of(property).is_at_most(max_length) }
    end

    it { is_expected.to validate_numericality_of(:book_rate) }

    context 'with text validations' do
      let(:valid_text) { Faker::Lorem.sentence }
      let(:invalid_text) { '@' }

      %i[title body].each do |property|
        it { is_expected.to allow_value(valid_text).for(property) }
        it { is_expected.not_to allow_value(invalid_text).for(property) }
      end
    end

    context 'with book existance' do
      let(:invalid_book_id) { -1 }

      it 'allows existed books' do
        review = described_class.new(book_id: create(:book).id)
        review.valid?
        expect(review.errors[:book]).to be_empty
      end

      it "doesn't allows not existed books" do
        review = described_class.new(book_id: invalid_book_id)
        review.valid?
        expect(review.errors[:book]).not_to be_empty
      end
    end
  end

  context 'with associations' do
    %i[book user].each do |model|
      it { is_expected.to belong_to(model) }
    end
  end

  context 'with model fields' do
    %i[title body book_rate date user_id book_id status].each do |field|
      it { is_expected.to have_db_column(field) }
    end
  end
end
