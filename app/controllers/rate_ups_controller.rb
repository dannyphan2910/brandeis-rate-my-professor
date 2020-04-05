class RateUpsController < ApplicationController
  before_action :login_required
  before_action :set_rate_up, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /rate_ups
  # GET /rate_ups.json
  def index
    @rate_ups = RateUp.all
  end

  # GET /rate_ups/1
  # GET /rate_ups/1.json
  def show
  end

  # GET /rate_ups/new
  def new
    @rate_up = RateUp.new
  end

  # GET /rate_ups/1/edit
  def edit
  end

  # POST /rate_ups
  # POST /rate_ups.json
  def create
    user_id = current_user.id
    review_id = params[:review_id]
    puts user_id, review_id
    if RateUp.exists?(user_id: user_id, review_id: review_id)
      RateUp.find_by(user_id: user_id, review_id: review_id).delete
    else
      RateUp.create(user_id: user_id, review_id: review_id)
    end
    @review = Review.find(review_id)
    respond_to do |format|
      format.js { }
    end
  end

  # PATCH/PUT /rate_ups/1
  # PATCH/PUT /rate_ups/1.json
  def update
    respond_to do |format|
      if @rate_up.update(rate_up_params)
        format.html { redirect_to @rate_up, notice: 'Rate up was successfully updated.' }
        format.json { render :show, status: :ok, location: @rate_up }
      else
        format.html { render :edit }
        format.json { render json: @rate_up.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rate_ups/1
  # DELETE /rate_ups/1.json
  def destroy
    @rate_up.destroy
    respond_to do |format|
      format.html { redirect_to rate_ups_url, notice: 'Rate up was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate_up
      @rate_up = RateUp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rate_up_params
      params.require(:rate_up).permit(:user_id, :review_id)
    end
end
