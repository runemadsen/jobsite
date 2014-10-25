module Madsen
  class AccessDenied < Exception
    def to_s
      "Access Denied"
    end
  end
end