require 'rails_helper'

describe Movie do
  describe "#find_movies_by_director" do
    before :each do
      @director1 = "John Smith"
      @director2 = "Not JS"
      @director3 = "Also Not JS"
      
      @movie1 = Movie.create(:title => "movie1", :director => @director1)
      @movie2 = Movie.create(:title => "movie2", :director => @director1)
      @movie3 = Movie.create(:title => "movie3", :director => @director2)
      @movie4 = Movie.create(:title => "movie4", :director => @director3)

    end
    it "invokes Movie where method using the director field" do
      expect(Movie).to receive(:where).with(:director => @director)
      Movie.new(:director => @director).find_movies_by_director
    end
    it "returns movies with the same director" do
      #movies = @movie1.find_movies_by_director
      expect(@movie1.find_movies_by_director).to include(@movie1).and include(@movie2)
      @movie1.find_movies_by_director
    end
    it "does not return movies with other directors" do
      expect(@movie1.find_movies_by_director).to include(@movie1).and include(@movie2)
      expect(@movie1.find_movies_by_director).not_to include(@movie3)
      expect(@movie1.find_movies_by_director).not_to include(@movie4)
      @movie1.find_movies_by_director
    end
  end
end