require_relative '../../spec_helper.rb'

describe "api/logins" do
  
  describe "POST" do

    context "if new email" do
      it "creates user and sends email" do
        expect(Pony).to receive(:deliver).once
        post '/api/logins', :email => "rune@runemadsen.com"
        expect(last_response.status).to eq(201)
        expect(User.count).to eq(1)
        expect(User.first.email).to eq("rune@runemadsen.com")
        expect(Login.count).to eq(1)
        expect(Login.first.user.email).to eq("rune@runemadsen.com")
      end
    end

    context "if existing email" do
      it "sends email" do
        User.create(:email => "rune@runemadsen.com")
        expect(Pony).to receive(:deliver).once
        post '/api/logins', :email => "rune@runemadsen.com"
        expect(last_response.status).to eq(200)
        expect(User.count).to eq(1)
      end
    end

    context "if invalid email" do
      it "returns error" do
        expect(Pony).to receive(:deliver).never
        post '/api/logins', :email => "Rune Madsen <rune@runemadsen.com>"
        expect(last_response.status).to eq(400)
        expect(User.count).to eq(0)
        expect(last_json["message"]).to eq(Madsen::WrongArgument.new(:email).to_s)
      end
    end

    context "if no email" do
      it "returns error" do
        expect(Pony).to receive(:deliver).never
        post '/api/logins'
        expect(last_response.status).to eq(422)
        expect(User.count).to eq(0)
        expect(last_json["message"]).to eq(Madsen::MissingArgument.new(:email).to_s)
      end
    end
    
  end

end