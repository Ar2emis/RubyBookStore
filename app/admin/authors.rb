ActiveAdmin.register Author do
  decorate_with AuthorDecorator
  permit_params :first_name, :last_name, :description

  index do
    selectable_column
    column :first_name
    column :last_name
    column :description do |author|
      truncate(author.description, length: 100)
    end
    actions
  end
end
