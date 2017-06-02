require 'spec_helper'
require 'rails_helper'

describe MoviesController do
  describe 'same director movies action' do
        before :each do
      @fake_movie = double('given_director_movie')
      @fake_results = [double('movie1'), double('movie2')]
      
    end
    it 'should call the model method to get the given movie details' do
      expect(Movie).to receive(:find).with('movie_id') {@fake_movie}
       allow(@fake_movie).to receive(:title)
       allow(Movie).to receive(:same_director_movies) {@fake_results}
  #    expect(Movie).to receive(:director_movies).with('hardware') { @fake_results }
       get :same_director, {:id => 'movie_id'}
    end
    it 'should call the model method to retrieve movies with the same director' do
       allow(Movie).to receive(:find)
       expect(Movie).to receive(:same_director_movies).with('movie_id') {@fake_results}
       allow(@movie).to receive(:title)
       get :same_director, {:id => 'movie_id'}
    end
    it 'should select template for rendering movies of known same director' do
       allow(Movie).to receive(:find)
       allow(Movie).to receive(:same_director_movies).with('movie_id'){@fake_results}
       allow(assigns flash[:notice])
       get :same_director, {:id => 'movie_id'}
       expect(response).to render_template('same_director')
    end
    it 'should make movies of the same director available to this template' do
       allow(Movie).to receive(:find)
       allow(Movie).to receive(:same_director_movies).with('movie_id'){@fake_results}
       allow(assigns flash[:notice]) #allow(@fake_movie).to receive(:title)
       get :same_director, {:id => 'movie_id'}
       expect(assigns(:movies)).to eq(@fake_results)
    end
    it 'should select template for rendering movies when director is unknown' do
       allow(Movie).to receive(:find).with('movie_id'){@fake_movie}
       allow(Movie).to receive(:same_director_movies).with('movie_id'){nil}
       allow(@fake_movie).to receive(:title){'Movie_title'}
       allow(assigns flash[:notice])
       get :same_director, {:id => 'movie_id'}
       expect(response).to redirect_to movies_path
    end

  end
end