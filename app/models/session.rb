class Session < Sequel::Model
  many_to_one :users
  self.raise_on_save_failure = true

  COOKIE_ID_KEY = :auth_user_id
  COOKIE_HASH_KEY = :auth_session_hash

  def self.create_and_authenticate_user(user_id, response)
    
    # save in DB
    session = self.create(:hash => SecureRandom.urlsafe_base64, :user_id => user_id)

    # send cookie back to user
    expires = 60 * 60 * 24 * 7  
    response.set_cookie COOKIE_ID_KEY, { value: uuid, max_age: expires.to_s }
    response.set_cookie COOKIE_HASH_KEY, { value: hash, max_age: expires.to_s }

    session

  end

  def self.find_by_cookie(request)
    return false if request.cookies[COOKIE_ID_KEY].nil? || request.cookies[COOKIE_HASH_KEY].nil?
    self.where(:user_id => request.cookies[COOKIE_ID_KEY], :hash => request.cookies[COOKIE_HASH_KEY]).first
  end

end