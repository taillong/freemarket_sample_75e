Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do 
    post 'person_infos', to: 'users/registrations#create_person_info'
    post 'addresses',    to: 'users/registrations#create_address'
    post 'card',         to: 'users/registrations#create_card'
    post 'skip',         to: 'users/registrations#create_skip'
  end
  root 'items#index'
  resource :user, only: :show do
    member do
      get :logout, :card
    end
    resources :cards, except: :index do
      member do
        post :buy
      end
    end
  end
  resources :items, except: :index do
    collection do 
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
    member do
      get :sell
    end
  end
end
