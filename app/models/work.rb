class Work < ApplicationRecord
  has_many :votes
  
  validates :category, presence: true;
  validates :title, presence: true, uniqueness: true
  validates :creator, presence: true
  validates :publication_year, presence: true #, numericality: { with: /\A\d{4}\z/, message: "Please Enter 4 Digit Year" }
  
  def total_votes
    upvotes = Vote.where(work_id: self.id)
    return upvotes.count
  end
  
  def self.spotlight 
    works = Work.all
    most_frequent_item = works.max_by{ |work| work.total_votes}
    return most_frequent_item
  end
  # def self.spotlight
  #   @works = Work.all
  #   most_frequent_item = @works.max_by{ |i| @works.count( i ) } 
  #   return most_frequent_item
  # end
  
  # def top_ten(category)
  #   works_to_sort = @works.where(category: category)
  #   works_to_sort.sort_by(:votes)
  #   return -works_to_sort.slice(0..9)
  # @works.each do |work|
  #   if work.category == category
  #     sorted = -works.sort_by { |work| work.vote.count }
  #   end
  #   return sorted.take(10)
  # end
  #end
  
  # def self.spotlight
  #   vote_count = {}
  #   @works.each do |work|
  #     vote_count[:work.title] => total_votes(work.id)
  #   end)
  #   top_work = hash.key(hash.values.max)
  #   return top_work
  # end
end
