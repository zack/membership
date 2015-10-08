class DbController < ApplicationController
  respond_to :html

  def index
    setup_frontend_data
  end
end
