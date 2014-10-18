module Madsen
  class App < Sinatra::Base
    
    post '/api/logins' do
      
      @email = params[:email]

      if valid_email?(@email)
        if User.where(:email => @email).first.nil?
          User.create(:email => @email)
        end
        send_email(@email, "Login to jobsite", "this is a login baby")
      else
        # raise wrong argument
      end
      
    end

  end
end