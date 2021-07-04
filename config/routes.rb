Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   devise_for :users, controllers: {
   sessions: 'users/sessions',
   registrations: 'users/registrations'
}
   root to: 'homes#top'
   resources :books do
     resource :favorites, only: [:create, :destroy]
     resources :book_comments, only: [:create, :destroy]
   end
   resources :users


   get "home/about" => "homes#about"

end
