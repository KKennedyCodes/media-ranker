class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  
  validates :user_id, presence: true;
  validates :work_id, presence: true;
  
  def sort_by_votes
    
  end
  
  def top_ten
    
  end
  
  def spotlight
  end
end
