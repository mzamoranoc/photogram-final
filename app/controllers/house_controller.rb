class HouseController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @users = User.order(username: :asc)
  end
end
