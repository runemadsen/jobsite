class User < Sequel::Model(:users)
  self.raise_on_save_failure = true
end