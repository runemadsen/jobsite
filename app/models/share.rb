class Share < Sequel::Model
  many_to_one :job
  many_to_one :sender, :class => :User
  many_to_one :receiver, :class => :User
  self.raise_on_save_failure = true

  def after_create
    Closure.create_from_users(self.sender_id, self.receiver_id)
    super
  end

end