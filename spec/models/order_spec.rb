RSpec.describe Order, type: :model do
  context 'with associations' do
    it { is_expected.to belong_to(:user).optional(true) }
    it { is_expected.to have_many(:order_items).dependent(:destroy) }

    %i[billing_address shipping_address order_coupon order_delivery_type card].each do |model|
      it { is_expected.to have_one(model).dependent(:destroy) }
    end

    { coupon: :order_coupon, delivery_type: :order_delivery_type }.each do |model, through_model|
      it { is_expected.to have_one(model).through(through_model) }
    end
  end

  context 'with model fields' do
    %i[user_id state number completed_at].each do |field|
      it { is_expected.to have_db_column(field) }
    end
  end

  context 'with aasm' do
    subject(:order) { build(:order) }

    [
      { from: :confirm, to: :addresses, event: :addresses_step },
      { from: %i[addresses confirm], to: :delivery, event: :delivery_step },
      { from: %i[delivery confirm], to: :payment, event: :payment_step },
      { from: :payment, to: :confirm, event: :confirm_step },
      { from: :confirm, to: :complete, event: :complete_step },
      { from: :complete, to: :in_queue, event: :in_queue_step },
      { from: :in_queue, to: :in_delivery, event: :in_delivery_step },
      { from: :in_delivery, to: :delivered, event: :delivered_step },
      { from: %i[in_queue in_delivery delivered], to: :canceled, event: :canceled_step }
    ].each do |transition|
      it { expect(order).to transition_from(*transition[:from]).to(transition[:to]).on_event(transition[:event]) }
    end
  end
end
