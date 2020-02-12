Rails.application.routes.draw do
  # Frontend
  get "/pages/:page", to: "pages#show"

  get "/404", to: "errors#not_found", via: :all
  get "/422", to: "errors#unprocessable_entity", via: :all
  get "/500", to: "errors#internal_server_error", via: :all

  namespace :teachers do
    resource :home, only: %i(show)
    resource :splash, only: %i(show)

    resource :session, only: %i(destroy) do
      get '/:token', to: 'sessions#create', as: 'create'
    end

    # resources :complete_curriculum_programmes, only: %i(index show), param: :slug, path: 'ccp' do
    #   resources :units, only: %i(show), param: :slug, path: '', controller: :unit do
    #     resources :lessons, only: %i(show), param: :slug, path: '' do
    #       resources :activities, param: :slug, path: ''
    #     end
    #   end
    # end

    get '/ccps/:slug', to: 'complete_curriculum_programmes#show', as: :complete_curriculum_programme
    get '/ccps', to: 'complete_curriculum_programmes#index', as: :complete_curriculum_programmes
    get '/ccps/:complete_curriculum_programme_slug/:slug', to: 'units#show', as: :complete_curriculum_programme_unit
    get '/ccps/:complete_curriculum_programme_slug/:unit_slug/:slug', to: 'lessons#show', as: :complete_curriculum_programme_unit_lesson
    get '/ccps/:complete_curriculum_programme_slug/:unit_slug/:lesson_slug/:slug', to: 'activities#show', as: :complete_curriculum_programme_unit_lesson_activity

    resource :logged_out, only: %i(show), controller: 'logged_out'
  end

  root to: 'teachers/homes#show'

  # API
  if Rails.env.development?
    mount OpenApi::Rswag::Ui::Engine => '/api-docs'
    mount OpenApi::Rswag::Api::Engine => '/api-docs'
  end

  namespace :api do
    namespace :v1 do
      resources :ccps, controller: 'complete_curriculum_programmes', only: %i(index show create update) do
        resources :units, only: %i(index show create update) do
          resources :lessons, only: %i(index show create update) do
            resources :lesson_parts, only: %i(index show)
          end
        end
      end
    end
  end
end
