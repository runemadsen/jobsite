class User < Sequel::Model
  one_to_many :logins
  self.raise_on_save_failure = true
end