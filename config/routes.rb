Rails.application.routes.draw do
  namespace :admin do
    get :download_all_form_templates
  end

  get :health, to: 'health#index'

  get :login, to: 'upvs#login'
  get :logout, to: 'upvs#logout'

  scope 'auth/saml', as: :upvs, controller: :upvs do
    get :login
    get :logout

    post :callback
  end

  scope :api do
    namespace :sktalk do
      post :receive
      post :receive_and_save_to_outbox
    end

    namespace :eform do
      post :validate
    end
  end
end
