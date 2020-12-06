RSpec.describe ReviewForm, type: :model do
  context 'with validations' do
    %i[title body book_id book_rate].each do |property|
      it { is_expected.to validate_presence_of(property) }
    end

    { title: described_class::TITLE_MAX_LENGTH, body: described_class::BODY_MAX_LENGTH }.each do |property, max_length|
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
  end
end
