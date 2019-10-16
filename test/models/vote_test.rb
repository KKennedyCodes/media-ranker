require "test_helper"

describe Vote do
  before do
    @user = users(:kennedy)
    @work = works(:pill)
    @vote = votes(:pill_vote)
  end
  
  describe "instantiations" do
    it "can be instantiated" do
      # Assert
      expect(@vote.valid?).must_equal true
    end
  end
  
  describe "validations" do
    it "requies work_id to be instantiated" do
      @vote.work_id = nil
      expect(@vote.valid?).must_equal false
      expect(@vote.errors.messages).must_include :work_id   
    end
    
    it "requies user_id to be instantiated" do
      @vote.user_id = nil
      expect(@vote.valid?).must_equal false
      expect(@vote.errors.messages).must_include :user_id   
    end
  end
  
  # describe "relations" do
  # end
  
  # describe "custom methods" do
  #   # it "totals user votes" do
  #   #   vote_total = total_votes(@user.id)
  #   #   expect(vote_total).must_equal 2
  #   # end
  # end
end