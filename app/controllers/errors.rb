module Madsen
  class App < Sinatra::Base

    error Madsen::MissingArgument do
      content_type :json
      status 422
      { message: env['sinatra.error'].message }.to_json
    end

  end
end