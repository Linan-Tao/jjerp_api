require 'doorkeeper/grape/helpers'
module V1
  class Users < Base
    helpers Doorkeeper::Grape::Helpers
    before do
      doorkeeper_authorize!
    end
    resources :users do
      get :emails do
        doorkeeper_authorize!
        # binding.pry
        # to do
        # [{'email' => current_user.email}]
      end
    end
  end
end