require 'rails_helper'

describe MoviesController do
  describe "#find_by_director" do
    context "When the movie has a director" do
      before :each do
        @director = "John Smith"
        @fake_id = "45"
        @movie1 = double("movie1", :director => @director)
        @movie2 = double("movie2", :director => @director)
        @fake_results = [@movie1, @movie2]
        @fake_movie = double("fake_movie", :director => @director, :find_movies_by_director => @fake_results)
      end
      it "determines the director" do
        expect(Movie).to receive(:find).with(@fake_id).and_return(@fake_movie)
        expect(@fake_movie).to receive(:director).and_return(@director)
        get :find_by_director, :id => @fake_id
      end
      it "returns movies list" do
        Movie.stub(:find).and_return(@fake_movie)
        @fake_movie.stub(:director).and_return(@director)
        expect(@fake_movie).to receive(:find_movies_by_director).and_return(@fake_results)
        get :find_by_director, :id => @fake_id
      end
      it "it selects the find_by_director template for rendering" do
        Movie.stub(:find).and_return(@fake_movie)
        @fake_movie.stub(:director).and_return(@director)
        @fake_movie.stub(:find_movies_by_director).and_return(@fake_results)
        get :find_by_director, :id => @fake_id
        expect(response).to render_template("find_by_director")
      end
      it "makes the director movie list available to the template" do
        Movie.stub(:find).and_return(@fake_movie)
        @fake_movie.stub(:director).and_return(@director)
        @fake_movie.stub(:find_movies_by_director).and_return(@fake_results)
        get :find_by_director, :id => @fake_id
        expect(assigns(:movies)).to eq(@fake_results)
      end
    end
    context "When the movie does not have a director" do
      before :each do
        @director = nil
        @fake_id = "45"
        @fake_movie = double("movie1", :director => @director, :title => "movie1")
      end
      it "determines that the director is nil" do
        expect(Movie).to receive(:find).with(@fake_id).and_return(@fake_movie) #could also be stub
        expect(@fake_movie).to receive(:director).and_return(@director) #could also be stub
        @fake_movie.stub(:find_movies_by_director).and_return(nil)
        get :find_by_director, :id => @fake_id
      end
      it "redirects to the homepage" do
        Movie.stub(:find).and_return(@fake_movie)
        @fake_movie.stub(:director).and_return(@director)
        @fake_movie.stub(:find_movies_by_director).and_return(nil)
        get :find_by_director, :id => @fake_id
        expect(response).to redirect_to(movies_path)
      end
      it "sets flash message" do
        Movie.stub(:find).and_return(@fake_movie)
        @fake_movie.stub(:director).and_return(@director)
        @fake_movie.stub(:find_movies_by_director).and_return(nil)
        get :find_by_director, :id => @fake_id
        expect(flash[:warning]).to eq("'#{@fake_movie.title}' has no director info.")
      end
    end
  end #describe "#find_by_director" do
  
  describe "#create" do
    before :each do
      @movie_title = "New Movie"
      @rating = "PG"
      @description = "My new movie is great"
      @release_date = "2016-03-18"
      @director = "Tom Kargul"
    end
    it "creates a new movie" do
      post :create, :movie => {:title => @movie_title, :rating => @rating, :description => @description, :release_date => @release_date, :director => @director}
      expect(assigns(:movie)).not_to be_nil
    end
    it "flashes a notice message" do
      post :create, :movie => {:title => @movie_title, :rating => @rating, :description => @description, :release_date => @release_date, :director => @director}
      expect(flash[:notice]).to eq("#{@movie_title} was successfully created.")
    end
    it "redirects to the homepage" do
      post :create, :movie => {:title => @movie_title, :rating => @rating, :description => @description, :release_date => @release_date, :director => @director}
      expect(response).to redirect_to(movies_path)
    end
  end #describe "#create" do
  
  describe "#destroy" do
    before :each do
      @id = "45"
      @movie_title = "The Eraser"
      @movie = double("movie", :title => @movie_title, :destroy => nil)

    end
    it "deletes the movie" do
      expect(Movie).to receive(:find).with(@id).and_return(@movie)
      expect(@movie).to receive(:destroy).with(no_args()).and_return(nil)
      delete :destroy, :id => @id
    end
    it "flashes a notice message" do
      Movie.stub(:find).and_return(@movie)
      @movie.stub(:destory).with(no_args()).and_return(nil)
      delete :destroy, :id => @id
      expect(flash[:notice]).to eq("Movie '#{@movie_title}' deleted.")
    end
    it "redirects to homepage" do
      Movie.stub(:find).and_return(@movie)
      @movie.stub(:destory).with(no_args()).and_return(nil)
      delete :destroy, :id => @id
      expect(response).to redirect_to(movies_path)
    end
  end #describe "#destroy" do

end