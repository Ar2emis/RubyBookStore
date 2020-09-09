require 'rails_helper'

RSpec.describe 'View more button', type: :feature do
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password }

  before do
    create_list(:book, books_amount)
    visit books_path
  end

  it 'displays View more button if not all books displayed' do
    expect(page).to have_content(view_more_button)
  end

  it 'hides View more button if all books displayed' do
    click_link(view_more_button)
    expect(page).not_to have_content(I18n.t('books.view_more'))
  end
end
