module Madsen
  class App < Sinatra::Base
    
    get '/' do
      erb :splash
    end

  end
end