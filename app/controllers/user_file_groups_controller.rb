class UserFileGroupsController < ApplicationController
  before_action :set_user_file_group, only: [:show, :edit, :update, :destroy]

  # GET /user_file_groups
  # GET /user_file_groups.json
  def index
    @user_file_groups = UserFileGroup.all
  end

  # GET /user_file_groups/1
  # GET /user_file_groups/1.json
  def show
  end

  # GET /user_file_groups/new
  def new
    @user_file_group = UserFileGroup.new
  end

  # GET /user_file_groups/1/edit
  def edit
  end

  # POST /user_file_groups
  # POST /user_file_groups.json
  def create
    @user_file_group = UserFileGroup.new(user_file_group_params)

    respond_to do |format|
      if @user_file_group.save
        format.html { redirect_to @user_file_group, info: 'User file group was successfully created.' }
        format.json { render :show, status: :created, location: @user_file_group }
      else
        format.html { render :new }
        format.json { render json: @user_file_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_file_groups/1
  # PATCH/PUT /user_file_groups/1.json
  def update
    respond_to do |format|
      if @user_file_group.update(user_file_group_params)
        format.html { redirect_to @user_file_group, info: 'User file group was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_file_group }
      else
        format.html { render :edit }
        format.json { render json: @user_file_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_file_groups/1
  # DELETE /user_file_groups/1.json
  def destroy
    @user_file_group.destroy
    respond_to do |format|
      format.html { redirect_to user_file_groups_url, info: 'User file group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_file_group
      @user_file_group = UserFileGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_file_group_params
      params.require(:user_file_group).permit(:desc, :name, :color)
    end
end
