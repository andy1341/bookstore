ActiveAdmin.register Order do
  permit_params :order, :status

  actions :all, except: [:destroy, :new]

  controller do
    def scoped_collection
      resource_class.for_admin
    end
  end

  after_save do |order|
    event = params[:order] && params[:order][:active_admin_requested_event]
    unless event.blank?
      safe_event = (order.aasm.events(permitted: true).map(&:name) & [event.to_sym]).first
      raise "Forbidden event #{event} requested on instance #{order.id}" unless safe_event
      order.send("#{safe_event}!")
    end
  end

  index do
    selectable_column
    id_column
    column :user do |order| order.user.try(:email) end
    state_column :status
    column :completed_date
    column :delivery
    column :created_at
    actions
  end

  show do
    attributes_table do
      state_row :status
      row :user
      row :completed_date
      row :delivery
      row :created_at
      row :billing_address do |order|
        print_address(order.billing_address.decorate)
      end
      row :shipping_address do |order|
        print_address(order.shipping_address.decorate)
      end
      row :credit_card do |order|
        print_credit_card(order.credit_card)
      end
      row :total
    end
  end

  form do |f|
    available_status = f.object.aasm.events(permitted: true).map(&:name)
    f.inputs 'Order Details' do
      next "<h2>You cann't change status</h2>".html_safe if  available_status.empty?
      f.input :active_admin_requested_event,
              label: "Change state #{f.object.status.humanize(capitalize: false)} to:",
              as: :select,
              collection: available_status
    end
    f.actions do
      action(:submit) unless available_status.empty?
      cancel_link
    end
  end
end
