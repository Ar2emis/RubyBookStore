ActiveAdmin.register Book do
  includes :category, :authors
  decorate_with BookDecorator
  permit_params :title, :price, :description, :publication_year,
                :width, :height, :depth, :title_image,
                :materials, :category_id, author_ids: [], images: []

  index do
    selectable_column
    column :title_image do |book|
      image_tag(book.title_image.url(:w170))
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
        image_tag(book.title_image.url(:w550))
      end
      book.images.each do |image|
        row :image do
          image_tag(image.url(:w200))
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
                            hint: (image_tag(book.title_image.url(:w550)) unless book.title_image.nil?)
      f.input :images, as: :file, input_html: { multiple: true }
    end
    actions
  end
end
