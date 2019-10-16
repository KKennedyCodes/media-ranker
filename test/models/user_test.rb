require "test_helper"

describe User do
  let (:new_user) {
  User.new(name: "Bob Bowers")
}
it "can be instantiated" do
  # Assert
  expect(new_user.valid?).must_equal true
end


end
