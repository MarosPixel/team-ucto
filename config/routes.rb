TeamUcto::Application.routes.draw do
  
  root to: "home#index"

  resources :events, except: :new
  get '/events/new/:type' => 'events#new', constraints: { type: /tournament|training|without_date/ }, as: :new_event

  resources :users
  devise_for :user, skip: [:sessions] do
    get    '/login'  => 'devise/sessions#new',     as:     :new_user_session
    post   '/login'  => 'devise/sessions#create',  as:         :user_session
    get    '/logout' => 'devise/sessions#destroy'
    delete '/logout' => 'devise/sessions#destroy', as: :destroy_user_session

    # pouzit -> skip: [:registrations, :sessions]  
    # get    '/registration'        => 'devise/registrations#new',     as:    :new_user_registration
    # post   '/registration'        => 'devise/registrations#create',  as:        :user_registration
    # get    '/registration/cancel' => 'devise/registrations#cancel',  as: :cancel_user_registration
    # get    '/user'                => 'devise/registrations#edit',    as:   :edit_user_registration
    # put    '/user'                => 'devise/registrations#update'
    # delete '/user'                => 'devise/registrations#destroy'
  end

  scope '/participation' do
    get    '' => 'participation#index', as: :participation
    post   '' => 'participation#add'
    delete '' => 'participation#delete'
  end

end
