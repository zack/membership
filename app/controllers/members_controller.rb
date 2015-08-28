class MembersController < ApplicationController
  helper_method :members, :member

  def members
    @_members ||= Member.all
  end

  def member
    @_member ||= members.find(params[:id])
  end
end
