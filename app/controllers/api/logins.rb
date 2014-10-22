module Madsen
  class App < Sinatra::Base

    post '/api/logins' do

      content_type :json
      validate_params!(params, :email)
      @email = params[:email]
      raise Madsen::WrongArgument.new(:email) unless valid_email?(@email)

      @user = User.find_or_create(:email => @email)
      @login = Login.create(:user_id => user.id)
      send_login_email(@user, @login)

      { :message => :ok }.to_json
    end

  end
end