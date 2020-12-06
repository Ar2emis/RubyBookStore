RSpec.describe 'Index', type: :feature do
  let(:reviews_amount) { 5 }

  describe 'unprocessed scope' do
    let!(:unprocessed_reviews) { create_list(:review, reviews_amount, status: Review.statuses[:unprocessed]) }

    before do
      admin_log_in
      click_link('Reviews')
    end

    %i[title status book_rate].each do |property|
      it "displays unprocessed reviews #{property}" do
        unprocessed_reviews.map(&property).each do |value|
          expect(page).to have_content(value)
        end
      end
    end

    it 'displays unprocessed reviews authors emails' do
      unprocessed_reviews.map { |review| review.user.email }.each do |email|
        expect(page).to have_content(email)
      end
    end
  end

  describe 'processed scope' do
    let!(:processed_reviews) { create_list(:review, reviews_amount) }

    before do
      admin_log_in
      click_link('Reviews')
      click_link('Processed')
    end

    %i[title status book_rate].each do |property|
      it "displays processed reviews #{property}" do
        processed_reviews.map(&property).each do |value|
          expect(page).to have_content(value)
        end
      end
    end

    it 'displays unprocessed reviews authors emails' do
      processed_reviews.map { |review| review.user.email }.each do |email|
        expect(page).to have_content(email)
      end
    end
  end
end
