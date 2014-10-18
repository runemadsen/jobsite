require_relative '../spec_helper.rb'

describe "Login" do

  describe "#create" do

    it "should generate token" do
      u = User.create(:email => 1)
      l = Login.create(:user_id => u.id)
      expect(l.token).to_not be_nil
    end

  end

end