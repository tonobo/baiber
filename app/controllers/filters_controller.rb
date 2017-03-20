class FiltersController < ApplicationController
  before_action :set_filter, only: [:show, :edit, :update, :destroy]

  # GET /filters
  # GET /filters.json
  def index
    @filters = Filter.all
  end

  # GET /filters/1
  # GET /filters/1.json
  def show
  end

  # GET /filters/new
  def new
    @filter = Filter.new
  end

  # GET /filters/1/edit
  def edit
  end

  # POST /filters
  # POST /filters.json
  def create
    @filter = Filter.new(filter_params)

    respond_to do |format|
      if @filter.save
        format.html { redirect_to @filter.email, info: 'Filter was successfully created.' }
        format.json { render :show, status: :created, location: @filter }
      else
        format.html { render :new }
        format.json { render json: @filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /filters/1
  # PATCH/PUT /filters/1.json
  def update
    respond_to do |format|
      if @filter.update(filter_params)
        format.html { redirect_to @filter.email, info: 'Filter was successfully updated.' }
        format.json { render :show, status: :ok, location: @filter }
      else
        format.html { render :edit }
        format.json { render json: @filter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /filters/1
  # DELETE /filters/1.json
  def destroy
    @filter.destroy
    respond_to do |format|
      format.html { redirect_to filters_url, info: 'Filter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filter
      @filter = Filter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def filter_params
      x = params.require(:filter).permit!
      if x.key? :email or x.key? :email_id
        x[:email] = current_user.emails.find_by!(id: x[:email_id] || x[:email])
        x.delete(:email_id)
      end
      x
    end
end
