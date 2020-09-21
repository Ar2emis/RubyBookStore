RSpec.describe 'Show', type: :feature do
  let(:review) { create(:review) }

  before do
    admin_log_in
    visit admin_review_path(review)
  end

  describe 'review data' do
    %i[title body book_rate].each do |attribute|
      it "displays review #{attribute}" do
        text = review.public_send(attribute)
        expect(page).to have_content(text)
      end
    end

    it 'displays review author email' do
      expect(page).to have_content(review.user.email)
    end

    it 'displays review  book title' do
      expect(page).to have_content(review.book.title)
    end
  end

  describe 'approve action' do
    before do
      click_link('Approve')
    end

    it 'displays approve message' do
      expect(page).to have_content('Approved!')
    end
  end

  describe 'reject action' do
    before do
      click_link('Reject')
    end

    it 'displays approve message' do
      expect(page).to have_content('Rejected!')
    end
  end
end
