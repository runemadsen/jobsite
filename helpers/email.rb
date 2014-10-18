module Madsen
  module Helpers
    module Mail
      
      def send_mail(to, subject, body)
        Pony.mail({
          :from => ENV["ROOT_EMAIL"],
          :to => to,
          :subject => subject,
          :body => body,
          :via => :smtp,
          :via_options => {
            :address              => ENV["SMTP_ADDRESS"],
            :port                 => ENV["SMTP_PORT"],
            :enable_starttls_auto => true,
            :user_name            => ENV["SMTP_USERNAME"],
            :password             => ENV["SMTP_PASSWORD"],
            :authentication       => :plain, # is this right?
            :domain               => ENV["ROOT_URL"]
          }
        })
      end
    end
  end
end