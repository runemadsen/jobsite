module Madsen
  class App < Sinatra::Base

    error Madsen::MissingArgument do
      content_type :json
      status 422
      { message: env['sinatra.error'].message }.to_json
    end

    error Madsen::WrongArgument do
      content_type :json
      status 400
      { message: env['sinatra.error'].message }.to_json
    end

    error Madsen::AccessDenied do
      content_type :json
      status 404
      { message: env['sinatra.error'].message }.to_json
    end

  end
end