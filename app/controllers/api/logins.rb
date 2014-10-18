module Madsen
  class App < Sinatra::Base

    post '/api/logins' do
      content_type :json
      validate_params!(params, :email)

      @email = params[:email]

      if !valid_email?(@email)
        raise Madsen::WrongArgument.new(:email)
      else
        user = User.where(:email => @email).first
        if user.nil?
          status 201
          user = User.create(:email => @email)
        end
        login = Login.create(:user_id => user.id)
        send_email(@email, "Login to jobsite", "this is a login baby")
        { :message => :ok }.to_json
      end
      
    end

  end
end