class Session < Sequel::Model
  many_to_one :users
  self.raise_on_save_failure = true

  def self.create_and_authenticate_user(user_id, response)
    
    # save in DB
    self.create(:hash => SecureRandom.urlsafe_base64, :user_id => user_id)

    # send cookie back to user
    expires = 60 * 60 * 24 * 7  
    response.set_cookie :auth_user_id, { value: uuid, max_age: expires.to_s }
    response.set_cookie :auth_session_hash, { value: hash, max_age: expires.to_s }

  end

end