class ContactController < ApplicationController
  def index
  end

  def submit
    @name = params[:name]
    @email = params[:email]
    @comment = params[:comment]
  end


end
