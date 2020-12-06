require 'rails_helper'

RSpec.describe 'books#show', type: :feature do
  let(:book) { create(:book) }

  describe 'book info' do
    before do
      visit book_path(book)
    end

    it 'displays book title' do
      expect(page).to have_content(book.title)
    end

    it 'displays book description' do
      expect(page).to have_content(book.description)
    end

    it 'displays book authors' do
      expect(page).to have_content(book.decorate.authors_names)
    end
  end

  describe 'review form', js: true do
    before do
      sign_in create(:user)
      visit book_path(book)
    end

    context 'with valid input' do
      let(:review_attributes) { attributes_for(:review) }

      before do
        fill_in(I18n.t('simple_form.placeholders.defaults.title'), with: review_attributes[:title])
        fill_in(I18n.t('simple_form.placeholders.defaults.body'), with: review_attributes[:body])
        page.all(:css, '.fa-star').first.click
        click_button(I18n.t('reviews.post'))
      end

      it 'displays success messasge' do
        expect(page).to have_content(I18n.t('reviews.success'))
      end
    end

    context 'with invalid input' do
      before do
        click_button(I18n.t('reviews.post'))
      end

      it { expect(page).to have_content(I18n.t('errors.messages.blank')) }
    end
  end

  describe 'reviews' do
    let(:reviews_amount) { 5 }
    let!(:reviews) { create_list(:review, 5, book: book) }

    before do
      visit book_path(book)
    end

    it 'displays reviews' do
      expect(page.all('.general-message-wrap.divider-lg').count).to eq reviews_amount
    end

    it 'displays reviews titles' do
      reviews.map(&:title).each do |title|
        expect(page).to have_content(title)
      end
    end

    it 'displays reviews bodies' do
      reviews.map(&:body).each do |body|
        expect(page).to have_content(body)
      end
    end
  end
end
