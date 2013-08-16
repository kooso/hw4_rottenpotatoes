class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  def self.find_same_director_as(title)
    movie = Movie.find_by_title(title)
    # breakpoint
    Movie.where(director: movie.director) unless movie.director == nil or movie.director == ''
  end
end
