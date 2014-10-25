require_relative '../spec_helper.rb'

describe "AuthToken" do

  describe "#create" do

    it "should generate token" do
      u = User.create(:email => 1)
      l = AuthToken.create(:user_id => u.id)
      expect(l.token).to_not be_nil
    end

  end

end