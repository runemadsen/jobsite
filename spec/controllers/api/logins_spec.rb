require_relative '../../spec_helper.rb'

describe "api/logins" do
  
  describe "POST" do

    context "if new email" do
      it "creates user and sends email" do
        expect(User.count).to eq(0)
        expect(Pony).to receive(:deliver).once
        post '/api/logins', :email => "rune@runemadsen.com"
        expect(last_response.status).to eq(201)
        expect(User.count).to eq(1)
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
    
  end

end