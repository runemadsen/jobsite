module Madsen
  class App < Sinatra::Base
    
    get '/' do
      @js_view = "SplashView"
      erb :splash
    end

  end
end