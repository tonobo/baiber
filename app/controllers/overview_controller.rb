class OverviewController < ApplicationController
  def index
    @unset_controls = true
    @user_files = current_user.user_files.order(id: :desc).limit(5)
    @emails= current_user.emails.order(id: :desc).limit(5)
  end
end
