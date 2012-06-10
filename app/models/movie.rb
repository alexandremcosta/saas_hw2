class Movie < ActiveRecord::Base
  def self.all_ratings
    select(:rating).group(:rating).map{|r| r.rating}
  end
end
