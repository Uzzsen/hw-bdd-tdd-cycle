class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
# def self.director_movies(drctor)
#    Movie.where(director: drctor)
# end
  
  def self.same_director_movies(id)
  movie = Movie.find(id)
  return Movie.where(director: movie.director) unless movie.director == ''
  end
    
end
