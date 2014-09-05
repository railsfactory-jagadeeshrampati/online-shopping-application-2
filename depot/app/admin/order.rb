ActiveAdmin.register Order do

 # config.filters = false
  actions :all, :except => [:new, :destroy]
  config.per_page = 10
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  #permit_params :list, :of, :attributes, :on, :model, :name, :address, :email, :pay_type
  permit_params :list, :of, :attributes, :on, :model, :status
   filter :name
   filter :pay_type
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
