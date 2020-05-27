Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do 
    # get 'person_infos', to: 'user/registrations#new_person_info'
    post 'person_infos', to: 'users/registrations#create_person_info'
    get  'addresses',    to: 'users/registrations#new_address'
    post 'addresses',    to: 'users/registrations#create_address'
  end
  root 'items#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :items, except: :index
end
