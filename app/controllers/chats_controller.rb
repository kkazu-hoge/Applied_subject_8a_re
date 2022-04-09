class ChatsController < ApplicationController
  include Common
  before_action :set_search_window
  before_action :verifi_datauser_loginuser_mdlbook, only: [:edit, :update]


  def index

  end

  def create
  end

end
