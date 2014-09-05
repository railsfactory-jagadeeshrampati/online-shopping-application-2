ActiveAdmin.register User do

  config.filters = false
  actions :all, :except => [:new]
  config.per_page = 2
index do
    selectable_column
    id_column
    column :name
    column :email
    column :current_sign_in_at
   
    column :created_at
    actions
  end
form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
