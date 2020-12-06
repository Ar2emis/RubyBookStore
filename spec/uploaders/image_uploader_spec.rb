RSpec.describe ImageUploader do
  subject(:uploader) { described_class.new(book, image) }

  let(:book) { create(:book) }
  let(:image) { :title_image }

  describe '#store_dir' do
    it 'returns path where uploads will be saved' do
      expected_path = "uploads/#{book.class.to_s.underscore}/#{image}/#{book.id}"
      expect(uploader.store_dir).to eq expected_path
    end
  end

  describe '#default_url' do
    let(:expected_image_url) { 'default_book' }

    it 'return default book url' do
      expect(uploader.default_url).to match(/#{expected_image_url}/)
    end
  end

  describe 'versions' do
    let(:image_path) { 'spec/support/fixtures/images/image.png' }

    before do
      described_class.enable_processing = true
      File.open(image_path) { |f| uploader.store!(f) }
    end

    after do
      described_class.enable_processing = false
      uploader.remove!
    end

    {
      w170: 170,
      w200: 200,
      w300: 300,
      w550: 550
    }.each do |width, pixels|
      context "with #{width} version" do
        it "has width: #{pixels} pixels" do
          expect(uploader.public_send(width)).to have_width(pixels)
        end
      end
    end
  end
end
