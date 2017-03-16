class EmailsController < ApplicationController
  before_action :set_email, only: [:show, :test, :edit, :update, :destroy]

  # GET /emails
  # GET /emails.json
  def index
    @emails = current_user.emails
  end

  # GET /emails/1
  # GET /emails/1.json
  def show
  end

  # GET /emails/new
  def new
    @email = Email.new
  end

  # GET /emails/1/edit
  def edit
  end

  def test(redirect: true)
    str = "#{@email.username} on #{@email.server}"
    if @email.works?
      flash[:success] = str + " works!"
    else
      flash[:danger] = str + " fails!"
    end
    if redirect
      redirect_back fallback_location: emails_path
    end
  end

  # POST /emails
  # POST /emails.json
  def create
    @email = Email.new(email_params)
    @email.user = current_user

    respond_to do |format|
      if @email.save
        test(redirect: false)
        format.html { redirect_to @email, info: 'Email was successfully created.' }
        format.json { render :show, status: :created, location: @email }
      else
        format.html { render :new }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /emails/1
  # PATCH/PUT /emails/1.json
  def update
    respond_to do |format|
      if @email.update(email_params)
        format.html { redirect_to @email, info: 'Email was successfully updated.' }
        format.json { render :show, status: :ok, location: @email }
      else
        format.html { render :edit }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emails/1
  # DELETE /emails/1.json
  def destroy
    @email.destroy
    respond_to do |format|
      format.html { redirect_to emails_url, info: 'Email was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = current_user.emails.find_by(id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_params
      params.require(:email).permit(:username, :password, :server, :port, :login, :ssl)
    end
end
