class User < Sequel::Model
  one_to_many :logins
  one_to_many :shares
  self.raise_on_save_failure = true
end