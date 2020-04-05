class RateDownsController < ApplicationController
  before_action :login_required
  before_action :set_rate_down, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /rate_downs
  # GET /rate_downs.json
  def index
    @rate_downs = RateDown.all
  end

  # GET /rate_downs/1
  # GET /rate_downs/1.json
  def show
  end

  # GET /rate_downs/new
  def new
    @rate_down = RateDown.new
  end

  # GET /rate_downs/1/edit
  def edit
  end

  # POST /rate_downs
  # POST /rate_downs.json
  def create
    user_id = current_user.id
    review_id = params[:review_id]
    puts user_id, review_id
    if RateDown.exists?(user_id: user_id, review_id: review_id)
      RateDown.find_by(user_id: user_id, review_id: review_id).delete
    else
      RateDown.create(user_id: user_id, review_id: review_id)
    end
    @review = Review.find(review_id)
    respond_to do |format|
      format.js { }
    end
  end

  # PATCH/PUT /rate_downs/1
  # PATCH/PUT /rate_downs/1.json
  def update
    respond_to do |format|
      if @rate_down.update(rate_down_params)
        format.html { redirect_to @rate_down, notice: 'Rate down was successfully updated.' }
        format.json { render :show, status: :ok, location: @rate_down }
      else
        format.html { render :edit }
        format.json { render json: @rate_down.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rate_downs/1
  # DELETE /rate_downs/1.json
  def destroy
    @rate_down.destroy
    respond_to do |format|
      format.html { redirect_to rate_downs_url, notice: 'Rate down was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate_down
      @rate_down = RateDown.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rate_down_params
      params.require(:rate_down).permit(:user_id, :review_id)
    end
end
