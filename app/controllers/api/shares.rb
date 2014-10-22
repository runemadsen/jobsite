module Madsen
  class App < Sinatra::Base

    post '/api/jobs/:job_id/shares' do

      # TODO: Check if this person has access to this job

      content_type :json
      validate_params!(params, :email, :sender_name, :receiver_name, :job_id)
      raise Madsen::WrongArgument.new(:email) unless valid_email?(params[:email])

      # update name of sender. Might be the first time we ever get it.

      @receiver = User.find_or_create(:email => params[:email]) { |u| u.name = params[:receiver_name] }

      if @receiver.has_share?(params[:job_id])
        # return a not modified code
      else
        # create share
        # create login
        # send email
      end
      
    end

  end
end