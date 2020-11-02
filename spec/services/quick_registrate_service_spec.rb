RSpec.describe QuickRegistrateService do
  let(:sign_up_params) { { email: attributes_for(:user)[:email] } }

  describe '.call' do
    it 'returns instance of the service' do
      expect(described_class.call(sign_up_params: sign_up_params)).to be_a described_class
    end
  end

  describe '#success?' do
    context 'when service successeded' do
      subject(:service) { described_class.call(sign_up_params: sign_up_params) }

      it 'returns true' do
        expect(service).to be_success
      end
    end

    context 'when service failed' do
      subject(:service) { described_class.call(sign_up_params: {}) }

      it 'returns false' do
        expect(service).not_to be_success
      end

      it 'has errors message' do
        expect(service.errors_message).to be_present
      end
    end
  end
end
