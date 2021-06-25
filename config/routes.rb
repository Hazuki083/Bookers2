Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   devise_for :users, controllers: {
   sessions: 'users/sessions',
   registrations: 'users/registrations'
}
   root to: 'homes#top'
   resources :books
   resources :users
   get "homes/about" => "homes#about"

end
