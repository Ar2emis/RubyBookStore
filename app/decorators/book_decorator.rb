class BookDecorator < ApplicationDecorator
  delegate_all
  decorates_association :authors

  def authors_names
    authors.map(&:full_name).join(', ')
  end

  def title_image_url(size: nil)
    image = size.present? ? resize_image(title_image, size) : title_image
    image.service_url
  end

  def images_urls(size: nil)
    converted_images = size.present? ? images.map { |image| resize_image(image, size) } : images
    converted_images.map(&:service_url)
  end

  private

  def resize_image(image, size)
    image.variant(resize: size).processed
  end
end
