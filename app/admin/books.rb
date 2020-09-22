ActiveAdmin.register Book do
  includes :category, :authors, title_image_attachment: :blob
  decorate_with BookDecorator
  permit_params :title, :price, :description, :publication_year,
                :width, :height, :depth, :title_image,
                :materials, :category_id, author_ids: [], images: []

  index do
    selectable_column
    column :title_image do |book|
      image_tag(book.title_image_url(size: '100x100')) if book.title_image.attached?
    end
    column :title do |book|
      link_to book.title, resource_path(book)
    end
    column :description do |book|
      truncate(book.description, length: 100)
    end
    column :authors, &:authors_names
    column :category
    column :price
    actions
  end

  show do
    attributes_table do
      row :title_image do |book|
        image_tag(book.title_image_url(size: '400x400')) if book.title_image.attached?
      end
      book.images_urls(size: '200x200').each do |url|
        row :image do
          image_tag(url)
        end
      end
      row :title
      row :authors, &:authors_names
      row :description
      row :publication_year
      row :category
      row :height
      row :width
      row :depth
      row :materials
      row :price
    end
  end

  form(html: { multipart: true }) do |f|
    f.inputs do
      f.input :category
      f.input :title
      f.input :authors, collection: Author.all.decorate(&:full_name), as: :check_boxes
      f.input :description
      f.input :price
      f.input :publication_year
      f.input :height
      f.input :width
      f.input :depth
      f.input :materials
      f.input :title_image, as: :file,
                            hint: if book.title_image.attached?
                                    image_tag(book.decorate.title_image_url(size: '400x400'))
                                  end
      f.input :images, as: :file, input_html: { multiple: true }
    end
    actions
  end

  controller do
    def find_resource
      scoped_collection.where(id: params[:id]).with_attached_images.first!
    end
  end
end
