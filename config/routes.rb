Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do 
    post 'person_infos', to: 'users/registrations#create_person_info'
    post 'addresses',    to: 'users/registrations#create_address'
  end
  root 'items#index'
  resources :items, except: :index
end
