require_relative '../spec_helper.rb'

describe "Share" do

  describe "#create" do

    before(:each) do
      @job = Job.create
      @u1 = User.create(:email => "user1@user.com")
      @u2 = User.create(:email => "user2@user.com")
      @u3 = User.create(:email => "user3@user.com")
      @u4 = User.create(:email => "user4@user.com")
      @s1 = Share.create(:job => @job, :sender => @u1, :receiver => @u2)
      @s2 = Share.create(:job => @job, :sender => @u2, :receiver => @u3)
      @s3 = Share.create(:job => @job, :sender => @u3, :receiver => @u4)
    end

    it "should set parent_id to parent share if appropriate" do
      expect(@s1.parent_id).to be_nil
      expect(@s2.parent_id).to eq(@s1.id)
      expect(@s3.parent_id).to eq(@s2.id)
    end
  
    it "should should create closure table" do
      expect(Closure.count).to eq(6)
      
      closures = Closure.all.map { |c| [c.parent_id, c.child_id, c.depth] }
      expect(closures).to eq([
        [@s1.id, @s1.id, 0],
        [@s2.id, @s2.id, 0],
        [@s1.id, @s2.id, 1],
        [@s3.id, @s3.id, 0],
        [@s2.id, @s3.id, 1],
        [@s1.id, @s3.id, 2]
      ]

      )
    end

  end

end