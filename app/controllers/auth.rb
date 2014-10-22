module Madsen
  class App < Sinatra::Base

    before {

      if params[:token]
        auth_token = AuthToken.where(:token => params[:token]).first
        if auth_token
          Session.create_and_authenticate_user(auth_token.user_id, response)
          @current_user = auth_token.user
        end
      end
    }

  end
end