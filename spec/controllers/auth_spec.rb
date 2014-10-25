require_relative '../spec_helper.rb'

describe "Authentication" do

  before(:each) do
    @user = User.create(:email => "rune@runemadsen.com")
  end

  describe "with token" do
    
    it "should authenticate if valid" do
      auth = AuthToken.create(:user => @user)
      get '/api/user', :token => auth.token
      expect(last_response).to be_ok
      expect(last_json["email"]).to eq(@user.email)
    end

    it "should not authenticate if not valid"
    it "should not authenticate if missing"
  end
  
end