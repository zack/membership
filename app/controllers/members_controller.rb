class MembersController < ApplicationController
  helper_method :members, :member

  respond_to :json
  respond_to :html

  def index
    respond_with members
  end

  def show
    respond_with member
  end

  def members
    @_members ||= Member.all
  end

  def member
    @_member ||= members.find(params[:id])
  end
end
