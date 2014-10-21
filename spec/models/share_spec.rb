require_relative '../spec_helper.rb'

describe "Share" do

  describe "#create" do
  
    it "should should create closure table" do
      expect(Closure.count).to eq(0)
      job = Job.create
      u1 = User.create(:email => "user1@user.com")
      u2 = User.create(:email => "user2@user.com")
      s = Share.create(:job => job, :sender => u1, :receiver => u2)
      expect(Closure.count).to eq(1)
    end

  end

end