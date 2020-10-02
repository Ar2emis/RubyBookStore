RSpec.describe CheckoutPresenter do
  subject(:presenter) { described_class.new(view: fake_view, order: order) }

  let(:order) { build(:order) }

  describe '#current_delivery?' do
    let(:delivery) { build(:delivery_type) }

    it 'returns true if delivery type the same as order delivery type' do
      order.delivery_type = delivery
      expect(presenter).to be_current_delivery(delivery, 0)
    end

    it 'returns true if order does not have delivery type and passed delivery tipe is first' do
      expect(presenter).to be_current_delivery(delivery, 0)
    end

    it 'returns false if order does not have delivery type and passed delivery tipe is not first' do
      expect(presenter).not_to be_current_delivery(delivery, 1)
    end
  end

  describe '#card' do
    let(:card) { build(:card, order: order) }

    it 'returns order card if order has card' do
      order.card = card
      expect(presenter.card).to eq card
    end

    it 'returns new card if order has not card' do
      expect(presenter.card).to be_a Card
    end
  end

  describe '#address' do
    let(:address) { build(:address, addressable: order) }

    it 'returns passed address if address presents' do
      expect(presenter.address(address)).to eq address
    end

    it 'returns new address if passed address is nil' do
      expect(presenter.address(nil)).to be_a Address
    end
  end

  describe '#address_full_name' do
    let(:address) { build(:address, addressable: order) }

    it 'returns first and last name from address' do
      full_name = "#{address.first_name} #{address.last_name}"
      expect(presenter.address_full_name(address)).to eq full_name
    end
  end

  describe '#address_city_with_zip' do
    let(:address) { build(:address, addressable: order) }

    it 'returns city and zip from address' do
      city_with_zip = "#{address.city} #{address.zip}"
      expect(presenter.address_city_with_zip(address)).to eq city_with_zip
    end
  end

  describe '#card_last_four_digits' do
    let(:card) { build(:card, order: order) }

    it 'returns order card last 4 digits' do
      order.card = card
      four_digits = card.number[-4..]
      expect(presenter.card_last_four_digits).to eq four_digits
    end
  end
end
