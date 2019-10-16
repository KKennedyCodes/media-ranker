require "test_helper"

describe User do
  before do
    @user = users(:kennedy)
  end
  it "can be instantiated" do
    # Assert
    expect(@user.valid?).must_equal true
  end
  
  
end
