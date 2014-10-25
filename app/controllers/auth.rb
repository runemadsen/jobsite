module Madsen
  class App < Sinatra::Base

    before {

      # If cookie was provided, log in user from cookie
      if session = Session.find_by_cookie(request)
        @current_user = session.user
      end
      
      # If token was provided, log in user from token
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