TeamUcto::Application.routes.draw do

  root to: 'home#index'

  resources :expenses,                              type: 'expense',      only: :index
  resources :trainings,      controller: :expenses, type: 'training'
  resources :tournaments,    controller: :expenses, type: 'tournament'
  resources :other_expenses, controller: :expenses, type: 'other_expense'

  resources :users, except: [ :new, :create ]
  devise_for :user, skip: [ :sessions ]
  devise_scope :user do
    get    '/login'  => 'devise/sessions#new',     as:     :new_user_session
    post   '/login'  => 'devise/sessions#create',  as:         :user_session
    get    '/logout' => 'devise/sessions#destroy'
    delete '/logout' => 'devise/sessions#destroy', as: :destroy_user_session
  end

  get    '/participations'          => 'participation#index', as: :participations
  post   '/participation/:eid/:uid' => 'participation#add',   as: :participation
  delete '/participation/:eid/:uid' => 'participation#delete'

  get '/postings/my',   as:   :my_postings
  get '/postings/all',  as:  :all_postings
  get '/postings/team', as: :team_postings

  resources :transactions, only: [ :index, :show ]
  resources :mails,  only: [ :index, :show ]
  resources :audits, only: :index

  get '/test' => 'test#index'

end
