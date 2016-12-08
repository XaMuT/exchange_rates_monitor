Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  scope module: :web do
    namespace :admin do
      resource :forced_rate, only: [:new, :create], controller: :forced_rate

      root to: 'forced_rate#new'
    end

    scope module: :public do
      root to: 'current_rate#show'
    end
  end
end
