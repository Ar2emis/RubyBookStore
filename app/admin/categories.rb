ActiveAdmin.register Category do
  permit_params :name

  index do
    selectable_column
    column :name do |category|
      link_to category.name, resource_path(category)
    end
    actions
  end
end
