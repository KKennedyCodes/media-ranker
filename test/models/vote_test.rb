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
  
  # describe "validations" do
  #   it "requies name to be instantiated" do
  #     @user.name = nil
  #     expect(@user.valid?).must_equal false
  #     expect(@user.errors.messages).must_include :name    
  #   end
  
  #   it "requies a unique name to be instantiated" do
  #     user_2 = User.new(name: "Katie Kennedy", join_date: Time.now)
  #     expect(user_2.valid?).must_equal false      
  #   end
  # end
  
  # describe "relations" do
  # end
  
  # describe "custom methods" do
  #   # it "totals user votes" do
  #   #   vote_total = total_votes(@user.id)
  #   #   expect(vote_total).must_equal 2
  #   # end
  # end
end