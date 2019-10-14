class User < ApplicationRecord
  has_many :votes
  
  valides :name, presence: true, uniqueness: true
  
  def total_votes
  end
end
