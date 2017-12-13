require 'pry'
class ShoutsController < ApplicationController
  def show
    @shout = Shout.find(params[:id])
  end
  
  def create
    @shout = current_user.shouts.create(shout_params)
    redirect_to root_path, redirect_option_for(@shout)
  end

  private

  def shout_params
    params.require(:shout).permit(:body)
  end

  def redirect_option_for(value)
    if value.persisted?
      { notice: "You've successfully Shouted" }
    else
      { alert: "Something went wrong with your Shout" }
    end
  end
end
