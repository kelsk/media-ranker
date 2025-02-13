require "test_helper"

describe User do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  describe "validation" do
    it "can create a valid user" do
      user = User.create(username: "Dorothy")
      
      is_valid = user.valid?
      
      assert( is_valid )    
    end
    
    it "will not login a user without a username" do
      user = User.create(username: nil)
      
      is_valid = user.valid?
      
      refute( is_valid )    
    end
    
    it "will not login a user with only spaces as a username" do
      user = User.create(username: "  ")
      
      is_valid = user.valid?
      
      refute( is_valid )    
    end
  end
  describe "user's votes" do
    it "can get a list of a user's votes" do
      user = User.first
      expect(user.votes.length).must_equal 1
      expect(user.votes.first.work_id).must_equal Vote.first.work_id
    end
  end
end
