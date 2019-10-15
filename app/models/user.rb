class User < ApplicationRecord
  has_many :votes
  
  validates :name, presence: true, uniqueness: true
  #(def self.total_votes)
  def total_votes(user_id)
    upvotes = Vote.where(user_id: user_id)
    return upvotes.count
  end
end
