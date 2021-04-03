Rails.application.routes.draw do
  devise_for :users
  resources :books
  post 'books/:id/reserve', to: 'books#reserve', as: 'reserve_book'
  post 'books/:id/unreserve', to: 'books#unreserve', as: 'unreserve_book'
  post 'books/:id/pay', to: 'books#pay', as: 'pay_book'
  post 'books/:id/unpay', to: 'books#unpay', as: 'unpay_book'

  root 'books#index'
end
