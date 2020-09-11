RSpec.describe AuthorDecorator do
  subject(:decorator) { author.decorate }

  let(:author) { build(:author) }

  describe '#full_name' do
    it 'returns author full name' do
      full_name = "#{author.first_name} #{author.last_name}"
      expect(decorator.full_name).to eq full_name
    end
  end
end
