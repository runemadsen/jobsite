module Madsen
  class App < Sinatra::Base
    
    post '/api/logins' do
      
      if valid_email?(params[:email])
        user = User.where(:email => params[:email]).first
        if user.nil?
          User.create(:email => params[:email])
        end
        send_email(params[:email], "Login to jobsite", "this is a login baby")
      else
        # raise wrong argument
      end
      
    end

  end
end