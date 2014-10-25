module Madsen
  module Helpers
    module Auth

      def authorize_user!
        raise Madsen::AccessDenied if @current_user.nil?
      end
      
      def authorize_job_access!

      end

    end
  end
end