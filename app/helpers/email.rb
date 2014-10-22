module Madsen
  module Helpers
    module Mail

      def valid_email?(email)
        !!email.match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i)
      end

      def send_login_email(user, login)
        @user = user
        @login = login
        send_email(@user.email, "Login to jobsite", erb(:'mails/splash_login', :layout => false))
      end

      def send_share_email(user, login, share)
        @user = user
        @login = login
        @share = share
        send_email(@user.email, "Someone shared a job with you", erb(:'mails/share_login', :layout => false))
      end
      
      def send_email(to, subject, body)
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