require "test_helper"

describe Vote do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  
  describe "validations" do
    it "allows a valid vote" do
      work = Work.first
      user = User.first
      
      vote = Vote.create(user_id: user.id, work_id: work.id)
      is_valid = vote.valid?
      
      assert(is_valid)
    end
    
    it "does not allow a duplicate vote" do
      work = Work.first
      user = User.first
      vote = Vote.create(user_id: user.id, work_id: work.id)
      work.reload
      
      vote = Vote.create(user_id: user.id, work_id: work.id)
      is_valid = vote.valid?
      
      refute(is_valid)
    end
    
    it "does not create a vote without a logged in user" do
      work = Work.first
      vote = Vote.create(user_id: nil, work_id: work.id)
      is_valid = vote.valid?
      
      refute(is_valid)
    end
    
    it "does not create a vote without a corresponding work" do
      user = User.first
      vote = Vote.create(user_id: user.id, work_id: nil)
      is_valid = vote.valid?
      refute(is_valid)
    end
  end

  describe "relationships" do
    it "has an id for a corresponding work" do
      id = Vote.first.work_id
      expect(Work.find_by(id: id)).must_be_instance_of Work
    end
    
    it "has an id for a corresponding user" do
      id = Vote.first.user_id
      expect(User.find_by(id: id)).must_be_instance_of User
    end
  end
end
