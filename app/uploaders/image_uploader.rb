class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  WIDTH_170 = 170
  WIDTH_200 = 200
  WIDTH_300 = 300
  WIDTH_550 = 550

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*_)
    ActionController::Base.helpers.asset_path('default_book.png')
  end

  version :w170 do
    process resize_to_fit: [WIDTH_170, nil]
  end

  version :w200 do
    process resize_to_fit: [WIDTH_200, nil]
  end

  version :w300 do
    process resize_to_fit: [WIDTH_300, nil]
  end

  version :w550 do
    process resize_to_fit: [WIDTH_550, nil]
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
