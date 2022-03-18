class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    render 'categories/index' if current_user
  end
end
