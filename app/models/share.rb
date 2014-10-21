class Share < Sequel::Model
  many_to_one :job
  many_to_one :user
  self.raise_on_save_failure = true
end