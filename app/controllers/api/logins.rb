module Madsen
  class App < Sinatra::Base

    INVALID_EMAIL = "It looks like you entered something that wasn't an email address"
    MISSING_EMAIL = "Please send a valid email address with this request"
    
    post '/api/logins' do
      content_type :json
      validate_params!(params, :email)

      @email = params[:email]

      if !valid_email?(@email)
        raise Madsen::WrongArgument.new(:email)
      else
        if User.where(:email => @email).first.nil?
          status 201
          User.create(:email => @email)
        end
        send_email(@email, "Login to jobsite", "this is a login baby")
        { :message => :ok }.to_json
      end
      
    end

  end
end