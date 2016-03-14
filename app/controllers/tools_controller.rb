class ToolsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tool, only: [:update, :destroy]
  before_action :set_listing
  authorize_resource

  def manage
    authorize! :manage, @listing
    tools = Tool.records(params[:listing_id])
    if tools.size.zero?
      @tool = Tool.new
    else
      @tool = tools[0]
    end
  end

  def create
    @tool = Tool.new(tool_params)
    if @tool.save
      redirect_to manage_listing_tools_path(@listing.id), notice: I18n.t('alerts.tools.save.success', model: Tool.model_name.human)
      #render json: { success: true, status: :created, location: @tool }
    else
      redirect_to manage_listing_tools_path(@listing.id), notice: I18n.t('alerts.tools.save.failure', model: Tool.model_name.human)
      #render json: { success: false, errors: @tool.errors, status: :unprocessable_entity }
    end
  end

  def update
    if @tool.update(tool_params)
      redirect_to manage_listing_tools_path(@listing.id), notice: I18n.t('alerts.tools.save.success', model: Tool.model_name.human)
      #render json: { success: true, status: :created, location: @tool }
    else
      redirect_to manage_listing_tools_path(@listing.id), notice: I18n.t('alerts.tools.save.failure', model: Tool.model_name.human)
      #render json: { success: false, errors: @tool.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @tool.destroy
    respond_to do |format|
      format.html { redirect_to tools_url, notice: 'Tool was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_tool
      @tool = Tool.find(params[:id])
    end

    def set_listing
      @listing = Listing.find(params[:listing_id])
    end

    def tool_params
      params.require(:tool).permit(:listing_id, :name, :image, :url)
        .merge(listing_id: @listing.id)
    end
end
