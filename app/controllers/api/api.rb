module Madsen
  class App < Sinatra::Base
    
    get '/api/user' do
      authorize_user!
      content_type :json
      { :email => @current_user.email }.to_json
    end

  end
end