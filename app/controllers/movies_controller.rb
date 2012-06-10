class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # Set table header class to hilite
    if params['order'] == 'title'
      @title_hilite = 'hilite'
    elsif params['order'] == 'release_date'
      @rd_hilite = 'hilite'
    end

    # Prepare checkboxes
    @all_ratings = Movie.all_ratings
    if params['ratings']
      selected_ratings = params['ratings'].keys
    else
      selected_ratings = @all_ratings
    end

    @checked = {}
    @all_ratings.each do |rating|
      if selected_ratings.include?(rating)
        @checked[rating] = true
      else
        @checked[rating] = false
      end
    end

    # Get data from DB respecting desired sorting and filtering
    @movies = Movie.where(rating: selected_ratings).order(params['order'])

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
