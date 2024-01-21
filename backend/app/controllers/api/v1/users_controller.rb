class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def me 
    render json: current_user, include: [:articles, :comments, :likes]
  end
end


