UserDefinedFields::Engine.routes.draw do
  get :data_types, controller: :database, action: :data_types
  get :tables, controller: :database, action: :tables

  resources :user_defined_fields
end
