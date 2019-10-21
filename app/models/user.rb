class User < ApplicationRecord
  has_many :votes
  
  validates :name, presence: true, uniqueness: true
  #(def self.total_votes)
  def total_votes(user_id)
    upvotes = Vote.where(user_id: user_id)
    return upvotes.count
  end
  
  def self.build_from_github(auth_hash)
    user = User.new
    user.uid = auth_hash[:uid]
    user.provider = "github"
    user.name = auth_hash["info"]["name"]
    user.email = auth_hash["info"]["email"]
    user.join_date = Time.now
    
    # Note that the user has not been saved.
    # We'll choose to do the saving outside of this method
    return user
  end
  
  
end
