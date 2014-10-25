require_relative '../spec_helper.rb'

describe "Authentication" do

  before(:each) do
    @user = User.create(:email => "rune@runemadsen.com")
  end

  describe "with token" do
    
    it "should authenticate if valid" do
      auth = AuthToken.create(:user => @user)
      get '/api/user', :token => auth.token
      expect(last_response.status).to eq(200)
      expect(last_json["email"]).to eq(@user.email)
    end

    it "should not authenticate if not valid" do
      get '/api/user', :token => "ABCDEFG"
      expect(last_response.status).to eq(404)
      expect(last_json["message"]).to eq("Access Denied")
    end

  end

  describe "with cookie" do

    it "should authenticate if valid" do
      s = Session.create(:user => @user)
      set_cookie "#{Session::COOKIE_ID_KEY}=#{s.user_id}" 
      set_cookie "#{Session::COOKIE_SHA_KEY}=#{s.sha}"
      get '/api/user'
      expect(last_response.status).to eq(200)
      expect(last_json["email"]).to eq(@user.email)
    end

    it "should not authenticate if not valid" do
      set_cookie "#{Session::COOKIE_ID_KEY}=#{@user.id}" 
      set_cookie "#{Session::COOKIE_SHA_KEY}=abcdefgh"
      get '/api/user'
      expect(last_response.status).to eq(404)
      expect(last_json["message"]).to eq("Access Denied")
    end

  end

  describe "with nothing" do

    it "should not authenticate if missing" do
      get '/api/user'
      expect(last_response.status).to eq(404)
      expect(last_json["message"]).to eq("Access Denied")
    end
    
  end
  
end