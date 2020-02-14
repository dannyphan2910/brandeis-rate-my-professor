class ProfessorRatingsController < ApplicationController
  before_action :set_professor_rating, only: [:show, :edit, :update, :destroy]

  # GET /professor_ratings
  # GET /professor_ratings.json
  def index
    @professor_ratings = ProfessorRating.all
  end

  # GET /professor_ratings/1
  # GET /professor_ratings/1.json
  def show
  end

  # GET /professor_ratings/new
  def new
    @professor_rating = ProfessorRating.new
  end

  # GET /professor_ratings/1/edit
  def edit
  end

  # POST /professor_ratings
  # POST /professor_ratings.json
  def create
    @professor_rating = ProfessorRating.new(professor_rating_params)

    respond_to do |format|
      if @professor_rating.save
        format.html { redirect_to @professor_rating, notice: 'Professor rating was successfully created.' }
        format.json { render :show, status: :created, location: @professor_rating }
      else
        format.html { render :new }
        format.json { render json: @professor_rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /professor_ratings/1
  # PATCH/PUT /professor_ratings/1.json
  def update
    respond_to do |format|
      if @professor_rating.update(professor_rating_params)
        format.html { redirect_to @professor_rating, notice: 'Professor rating was successfully updated.' }
        format.json { render :show, status: :ok, location: @professor_rating }
      else
        format.html { render :edit }
        format.json { render json: @professor_rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /professor_ratings/1
  # DELETE /professor_ratings/1.json
  def destroy
    @professor_rating.destroy
    respond_to do |format|
      format.html { redirect_to professor_ratings_url, notice: 'Professor rating was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_professor_rating
      @professor_rating = ProfessorRating.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def professor_rating_params
      params.require(:professor_rating).permit(:review_id, :cat1, :cat2, :cat3, :cat4, :cat5, :strength, :improvement)
    end
end
