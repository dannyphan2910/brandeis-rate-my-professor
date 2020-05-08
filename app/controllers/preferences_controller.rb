class PreferencesController < ApplicationController
  before_action :set_preference, only: [:show, :edit, :update, :destroy]

  # GET /preferences
  # GET /preferences.json
  def index
    @preferences = Preference.all
  end

  # GET /preferences/1
  # GET /preferences/1.json
  def show
  end

  # GET /preferences/new
  def new
    @preference = Preference.new
  end

  # GET /preferences/1/edit
  def edit
  end

  # POST /preferences
  # POST /preferences.json
  def create
    if params[:pref_participation] && params[:pref_workload] && params[:pref_grading] 
      if !Preference.exists?(user_id: current_user.id)
        @preference = Preference.new(
          user_id: current_user.id, 
          likes_participation: params[:pref_participation] == "no",
          likes_workload: params[:pref_workload] == "no",
          likes_testing: params[:pref_grading] == "no"
        )
      else 
        @preference = Preference.find_by(user_id: current_user.id).update(
          likes_participation: params[:pref_participation] == "no",
          likes_workload: params[:pref_workload] == "no",
          likes_testing: params[:pref_grading] == "no"
        )
      end
    end

    respond_to do |format|
      if @preference
        format.html { redirect_to '/view_profile', notice: 'Your preferences have been successfully recorded.'} 
      else
        format.html { }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /preferences/1
  # PATCH/PUT /preferences/1.json
  def update
    respond_to do |format|
      if @preference.update(preference_params)
        format.html { redirect_to @preference, notice: 'Preference was successfully updated.' }
        format.json { render :show, status: :ok, location: @preference }
      else
        format.html { render :edit }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /preferences/1
  # DELETE /preferences/1.json
  def destroy
    @preference.destroy
    respond_to do |format|
      format.html { redirect_to preferences_url, notice: 'Preference was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_preference
      @preference = Preference.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def preference_params
      params.require(:preference).permit(:user_id, :likes_participation, :likes_workload, :likes_testing)
    end
end
