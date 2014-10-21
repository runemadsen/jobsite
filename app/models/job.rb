class Job < Sequel::Model
  one_to_many :shares
  self.raise_on_save_failure = true
end