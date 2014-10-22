class Share < Sequel::Model
  many_to_one :job
  many_to_one :sender, :class => :User
  many_to_one :receiver, :class => :User
  self.raise_on_save_failure = true

  def before_create
    # find the parent share. We need it to form a tree for the shares.
    parent = Share.where(:job_id => self.job_id, :receiver_id => self.sender_id).first
    self.parent_id = parent.nil? ? nil : parent.id
  end

  def after_create
    Closure.create_for_share(self)
    super
  end

end