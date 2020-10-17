ActiveAdmin.register Book do
  includes :category, :authors
  decorate_with BookDecorator
  permit_params :title, :price, :description, :publication_year,
                :width, :height, :depth,
                :material, :category_id, author_ids: []

  index do
    selectable_column
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
    end
    actions
  end
end
