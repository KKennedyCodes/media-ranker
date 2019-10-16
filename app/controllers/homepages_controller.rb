class HomepagesController < ApplicationController
  def self.top_ten
    @albums.sort_by!(&:votes)
    @books.sort_by!(&:votes)
    @movies.sort_by!(&:votes)
  end
end
