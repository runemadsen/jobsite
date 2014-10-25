class Session < Sequel::Model
  many_to_one :user
  self.raise_on_save_failure = true

  COOKIE_ID_KEY = "auth_user_id"
  COOKIE_SHA_KEY = "auth_session_sha"

  def self.create_and_authenticate_user(user_id, response)
    
    # save in DB
    session = self.create(:user_id => user_id)

    # send cookie back to user
    expires = 60 * 60 * 24 * 7  
    response.set_cookie COOKIE_ID_KEY, { value: session.user_id, max_age: expires.to_s }
    response.set_cookie COOKIE_SHA_KEY, { value: session.hash, max_age: expires.to_s }

    session

  end

  def before_create
    self.sha = SecureRandom.urlsafe_base64
    super
  end

  def self.find_by_cookie(request)
    return false if request.cookies[COOKIE_ID_KEY].nil? || request.cookies[COOKIE_SHA_KEY].nil?
    self.where(:user_id => request.cookies[COOKIE_ID_KEY], :sha => request.cookies[COOKIE_SHA_KEY]).first
  end

end