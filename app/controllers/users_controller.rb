class UsersController < ApplicationController
  def index
    if current_user.employer?
      @applicants = current_user.applicants
      render 'applicants'
      return
    else
      @new_employers = User.employer - current_user.employers
      render 'employers'
    end
  end
end
