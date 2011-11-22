TeamUcto::Application.routes.draw do
  
  root to: 'home#index'

  resources :expenses,                              type: 'expense',      only: :index
  resources :trainings,      controller: :expenses, type: 'training'
  resources :tournaments,    controller: :expenses, type: 'tournament'
  resources :other_expenses, controller: :expenses, type: 'other_expense'

  resources :users, except: [ :new, :create ]
  devise_for :user, skip: [ :sessions ] do
    get    '/login'  => 'devise/sessions#new',     as:     :new_user_session
    post   '/login'  => 'devise/sessions#create',  as:         :user_session
    get    '/logout' => 'devise/sessions#destroy'
    delete '/logout' => 'devise/sessions#destroy', as: :destroy_user_session
  end

  scope '/participation' do
    get    '' => 'participation#index', as: :participation
    post   '' => 'participation#add'
    delete '' => 'participation#delete'
  end

end
