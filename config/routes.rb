Rails.application.routes.draw do

    # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }


    namespace :admin do
    get '/' , to: 'homes#top', as: 'top'
    resources:items
    resources:customers
    resources:orders
    resources:order_details
 end



    scope module: :public do
    resources:homes
    resources:items
    resources:customers
    resources :cart_items, only: [:index,:create, :destroy,:update]

    get '/' , to: 'homes#top' , as: 'customer_top'
    get '/about' , to: 'homes#about' , as: 'customer_about'
    get '/customers/my_page', to: 'customers#show', as: 'customers_my_page'
    patch '/customers/information', to: 'customers#update', as: 'customers_update'
    get '/customers/unsubscribe', to: 'customers#unsubscribe', as: 'customers_unsubscribe'
    patch '/customers/withdraw', to: 'customers#withdraw', as: 'customers_withdraw'
    delete '/cart_items/destroy_all', to: 'cart_items#destroy_all', as: 'cart_items_destroy_all'
    resources :orders do
     collection do
     post '/confirm', to: 'orders#confirm', as: 'confirm'
     get '/complete', to: 'orders#complete', as: 'complete'
     end
    end
 end



  # devise_for :users



  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
