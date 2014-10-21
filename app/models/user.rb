class User < Sequel::Model
  one_to_many :logins
  one_to_many :sent_shares, :class=>:Share, :key=> :sender_id
  one_to_many :received_shares, :class=>:Share, :key=> :receiver_id
  self.raise_on_save_failure = true
end