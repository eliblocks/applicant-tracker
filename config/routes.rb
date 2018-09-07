Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root "users#index"
  end

  devise_scope :user do
    root 'devise/sessions#new'
  end

  resources :job_applications, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
