class Login < Sequel::Model
  many_to_one :user
  self.raise_on_save_failure = true

  def before_create
    self.token = SecureRandom.uuid
    super
  end

end