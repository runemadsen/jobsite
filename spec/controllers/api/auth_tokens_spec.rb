require_relative '../../spec_helper.rb'

describe "api/auth_tokens" do
  
  describe "POST" do

    def expect_one_user_with_login
      expect(User.count).to eq(1)
      expect(Login.count).to eq(1)
      expect(User.first.email).to eq("rune@runemadsen.com")
      expect(Login.first.user.email).to eq("rune@runemadsen.com")
    end

    def expect_no_user_or_login
      expect(User.count).to eq(0)
      expect(Login.count).to eq(0)
    end

    context "if new email" do
      it "creates user and sends email" do
        expect(Pony).to receive(:deliver).once
        post '/api/auth_tokens', :email => "rune@runemadsen.com"
        expect(last_response.status).to eq(200)
        expect_one_user_with_login
      end
    end

    context "if existing email" do
      it "sends email" do
        User.create(:email => "rune@runemadsen.com")
        expect(Pony).to receive(:deliver).once
        post '/api/auth_tokens', :email => "rune@runemadsen.com"
        expect(last_response.status).to eq(200)
        expect_one_user_with_login
      end
    end

    context "if invalid email" do
      it "returns error" do
        expect(Pony).to receive(:deliver).never
        post '/api/auth_tokens', :email => "Rune Madsen <rune@runemadsen.com>"
        expect(last_response.status).to eq(400)
        expect_no_user_or_login
        expect(last_json["message"]).to eq(Madsen::WrongArgument.new(:email).to_s)
      end
    end

    context "if no email" do
      it "returns error" do
        expect(Pony).to receive(:deliver).never
        post '/api/auth_tokens'
        expect(last_response.status).to eq(422)
        expect_no_user_or_login
        expect(last_json["message"]).to eq(Madsen::MissingArgument.new(:email).to_s)
      end
    end
    
  end

end