module Madsen
  class App < Sinatra::Base
    
    get '/jobs/new' do
      @js_view = "JobsNewView"
      erb :'jobs/new'
    end

  end
end