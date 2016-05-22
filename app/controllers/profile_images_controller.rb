class ProfileImagesController < ApplicationController
  before_action :authenticate_user?
  before_action :set_profile, only: [:show]
  before_action :set_my_profile, only: [:edit, :update, :destroy]
  before_action :set_profile_image, only: [:show]
  before_action :set_my_profile_image, only: [:edit, :update, :destroy]
  authorize_resource through: :profile

  # GET /profile_images/new
  def new
    @profile_image = ProfileImage.new
  end

  # GET /profile_images/1/edit
  def edit
  end

  # POST /profile_images
  # POST /profile_images.json
  def create
    @profile_image = ProfileImage.new(profile_image_params)
    respond_to do |format|
      if @profile_image.save
        format.html { redirect_to profile_path(@profile.id), notice: I18n.t('alerts.profile_images.save.success', model: ProfileImage.model_name.human) }
        format.json { render :show, status: :created, location: @profile_image }
      else
        format.html { render :new }
        format.json { render json: @profile_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profile_images/1
  # PATCH/PUT /profile_images/1.json
  def update
    respond_to do |format|
      if @profile_image.update(profile_image_params)
        format.html { redirect_to profile_path(@profile.id), notice: I18n.t('alerts.profile_images.save.success') }
        format.json { render :show, status: :ok, location: @profile_image }
      else
        format.html { render :edit }
        format.json { render json: @profile_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profile_images/1
  # DELETE /profile_images/1.json
  def destroy
    @profile_image.destroy
    respond_to do |format|
      format.html { redirect_to profile_images_url, notice: 'Profile image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_image
      @profile_image = ProfileImage.find(params[:id])
    end

    def set_my_profile_image
      @profile_image = ProfileImage.where(user_id: current_user.id, profile_id: current_user.profile.id).first || ProfileImage.new
    end

    def set_profile
      @profile = Profile.find(params[:profile_id])
    end

    def set_my_profile
      @profile = Profile.find(current_user.profile.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_image_params
      params.require(:profile_image).permit(:user_id, :profile_id, :image, :caption)
        .merge(user_id: current_user.id)
    end
end
