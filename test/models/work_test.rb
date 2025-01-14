require "test_helper"

describe Work do
  # it "does a thing" do
  #   value(1+1).must_equal 2
  # end
  describe "validations" do
    it "correctly validates a work with a unique title" do
      # Arrange
      work = Work.find_by(title: "Millions of Cats")
      # Act
      is_valid = work.valid?
      # Assert
      assert( is_valid )
    end
    
    it "invalidates a work with no title" do
      # Arrange
      work = Work.new(category: "book")
      # Act
      is_valid = work.valid?
      # Assert
      refute( is_valid )
    end
    
    it "invalidates a work whose title is not unique within the scope of the category" do
      # Arrange
      work = Work.new(category: "book", title: "Millions of Cats")
      # Act
      is_valid = work.valid?
      # Assert
      refute( is_valid )
    end
  end
  
  describe "custom methods" do
    it "can get a work's votes" do
      work = Work.find_by(title: "Millions of Cats")
      expect(work.votes.length).must_equal 2
      expect(work.votes.first.work_id).must_equal Vote.first.work_id
    end
    
    it "can get the top ten works by vote" do
      # Arrange
      top_ten = Work.top_ten("book")
      spotlight = Work.spotlight
      # Act
      # Assert
      expect(top_ten.length).must_equal 10
      expect(top_ten.first.id).must_equal spotlight.id
    end
    
    it "retrieves fewer than ten works if fewer than ten are in the category" do
      # Arrange
      top_works = Work.top_ten("album")
      # Act
      # Assert
      expect(top_works.length).must_equal Work.where(category: "album").length
      expect(top_works.first.id).must_equal Work.where(category: "album").first.id
      
    end
    
    it "can get the work with the highest vote" do
      work = Work.find_by(title: "Millions of Cats")
      
      spotlight = Work.spotlight
      
      expect(spotlight.votes.length).must_equal work.votes.length      
    end
    
    it "updates the Media Spotlight if another work gets more votes" do
      work1 = Work.find_by(title: "Millions of Cats")
      work2 = Work.find_by(title: "Permission To Land")
      user1 = User.find_by(username: "Rose")
      user2 = User.find_by(username: "Blanche")
      
      spotlight = Work.spotlight
      
      expect(spotlight.title).must_equal work1.title
      
      vote = Vote.create(user_id: user1.id, work_id: work2.id)
      vote = Vote.create(user_id: user2.id, work_id: work2.id)
      
      work2.reload
      spotlight = Work.spotlight
      
      expect(spotlight.title).must_equal work2.title
    end
    
    it "maintains the current Media Spotlight if another work gets the same number of votes" do
      # this test does not accurately test the Media Spotlight
      # the Media Spotlight returns the first element in the database in the event of a tie
      # I believe this is how the original Media Ranker is handling ties
      
      work1 = Work.find_by(title: "Millions of Cats")
      work2 = Work.find_by(title: "Permission To Land")
      user = User.find_by(username: "Rose")
      
      spotlight = Work.spotlight
      
      expect(spotlight.title).must_equal work1.title
      
      vote = Vote.create(user_id: user.id, work_id: work2.id)
      
      work2.reload
      spotlight = Work.spotlight
      
      expect(spotlight.title).must_equal work1.title
    end
  end
end
