module Madsen
  class App < Sinatra::Base

    post '/api/logins' do

      content_type :json
      validate_params!(params, :email)

      @email = params[:email]

      if !valid_email?(@email)
        raise Madsen::WrongArgument.new(:email)
      else
        user = User.find_or_create(:email => @email)
        login = Login.create(:user_id => user.id)
        @token = login.token
        send_email(@email, "Login to jobsite", erb(:'mails/splash_login', :layout => false))
        { :message => :ok }.to_json
      end
      
    end

  end
end