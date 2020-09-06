require 'rails_helper'

RSpec.describe Book, type: :model do
  describe '.ordered' do
    let(:sort_symbol) { :atoz }
    let(:invalid_sort_symbol) { :invalid_sort }
    let(:books_amount) { 3 }

    before do
      create_list(:book, books_amount)
    end

    it 'sorts by predefined in model sort scopes' do
      sorted_by_title_books = described_class.order(:title).map(&:title)
      expect(described_class.ordered(sort_symbol).map(&:title)).to eq sorted_by_title_books
    end

    it "doesn't sort if no scope provided in model for passed symbol" do
      sorted_by_title_books = described_class.all.map(&:title)
      expect(described_class.ordered(invalid_sort_symbol).map(&:title)).to eq sorted_by_title_books
    end
  end
end
