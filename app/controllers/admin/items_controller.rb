class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  def index
  end

  def create
  end
end