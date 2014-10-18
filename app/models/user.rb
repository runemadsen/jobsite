module Madsen

  class User < Sequel::Model(:users)

    def exists?(email)

    end

    self.raise_on_save_failure = true
  end

end