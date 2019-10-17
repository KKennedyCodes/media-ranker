require "test_helper"

describe Work do
  before do
    @user = users(:kennedy)
    @work = works(:pill)
    @vote = votes(:pill_vote)
  end
  
  describe "instantiations" do
    it "can be instantiated" do
      # Assert
      expect(@work.valid?).must_equal true
    end
  end
  
  describe "validations" do
    it "requies title to be instantiated" do
      @work.title = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :title   
    end
    
    it "requies category to be instantiated" do
      @work.category = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :category   
    end
    
    it "requies creator to be instantiated" do
      @work.creator = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :creator   
    end
    
    it "requies publication year to be instantiated" do
      @work.publication_year = nil
      expect(@work.valid?).must_equal false
      expect(@work.errors.messages).must_include :publication_year   
    end
    
    it "requies a unique title to be instantiated" do
      work_2 = Work.new(category: "album", title: "Jagged Little Pill", creator: "Alanis Morisette", publication_year: 1995, description: "test")
      expect(work_2.valid?).must_equal false      
    end
  end
  
  # describe "relations" do
  # end
  
  # describe "custom methods" do
  #   # it "totals user works" do
  #   #   work_total = total_works(@user.id)
  #   #   expect(work_total).must_equal 2
  #   # end
  # end
end

