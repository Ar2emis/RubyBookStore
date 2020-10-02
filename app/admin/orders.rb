ActiveAdmin.register Order do
  permit_params :number, :completed_at, :state, :delivery_type
  actions :index, :show

  scope :in_progress, default: true
  scope :delivered
  scope :canceled

  index do
    selectable_column
    column :number
    column :state
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :number
      row :status
      row :created_at
      row :coupon
      row :delivery_type
    end
  end

  batch_action I18n.t('activeadmin.orders.change_to_in_delivery'),
               if: proc { @current_scope.scope_method == :in_progress } do |ids|
    orders = Order.in_progress.where(id: ids)
    orders.any? ? orders.each(&:in_delivery_step!) : flash[:error] = I18n.t('admin.error')
    redirect_to(admin_orders_path)
  end

  batch_action I18n.t('activeadmin.orders.change_to_delivered'),
               if: proc { @current_scope.scope_method == :in_progress } do |ids|
    orders = Order.in_delivery.where(id: ids)
    orders.any? ? orders.each(&:delivered_step!) : flash[:error] = I18n.t('admin.error')
    redirect_to(admin_orders_path)
  end

  batch_action I18n.t('activeadmin.orders.change_to_in_canceled'),
               if: proc { @current_scope.scope_method != :canceled } do |ids|
    orders = Order.where(id: ids)
    orders.any? ? orders.each(&:canceled_step!) : flash[:error] = I18n.t('admin.error')
    redirect_to(admin_orders_path)
  end
end
