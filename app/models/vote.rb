class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  
  validates :user_id, presence: true;
  validates :work_id, presence: true;
  
  def top_ten(media_type)
  end
  
  def spotlight
  end
end
