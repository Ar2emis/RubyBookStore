ActiveAdmin.register Author do
  decorate_with AuthorDecorator
  permit_params :first_name, :last_name, :description

  index do
    selectable_column
    column :name do |author|
      link_to author.full_name, resource_path(author)
    end
    actions
  end
end
