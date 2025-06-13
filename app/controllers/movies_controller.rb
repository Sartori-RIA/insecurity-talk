class MoviesController < ApplicationController
  # load_and_authorize_resource
  before_action :set_movie, only: %i[ show edit update destroy ]

  def index
    @movies = Movie.all.order(updated_at: :desc)
    @movies = Movie.where("title = '#{params[:q]}'") if params[:q].present? # TODO UNSAFE
    @movies = Movie.where("title = ?", params[:q1]) if params[:q1].present? # TODO SAFE
    # @movies = Movie.where(title: params[:q2]) if params[:q2].present? # TODO SAFE
  end

  def show; end

  def new
    @movie = Movie.new
  end

  def edit; end

  def create
    # @movie = Movie.new(params[:movie].permit!) # TODO UNSAFE


    # UNSAFE file uploader
    # uploaded = params.to_h.dig(:movie, :image)
    # path = Rails.root.join("public/uploads/#{uploaded.original_filename}")
    # File.open(path, "wb") { |f| f.write(uploaded.read) }
    # render json: { status: "uploaded", url: "/uploads/#{uploaded.original_filename}" }

    @movie = Movie.new(movie_params) # TODO SAFE

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @movie.destroy!

    respond_to do |format|
      format.html { redirect_to movies_path, status: :see_other, notice: "Movie was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_movie
    @movie = Movie.find_by!("id = #{params[:id]}") # insecure
    # @movie = Movie.find(params[:id]) # safe
  end

  def movie_params
    params.require(:movie).permit(:title, :category, :description, :year, :image)
  end
end
