class User < ApplicationRecord
  has_many :votes
  
  validates :name, presence: true, uniqueness: true
  
  def total_votes
  end
end
