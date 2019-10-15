class Work < ApplicationRecord
  has_many :votes
  
  validates :category, presence: true;
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :publication_year, presence: true #, numericality: { with: /\A\d{4}\z/, message: "Please Enter 4 Digit Year" }
  
  def total_votes(work_id)
    upvotes = Vote.where(work_id: work_id)
    return upvotes.count
  end
end
