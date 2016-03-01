class MembersController < ApplicationController
  helper_method :members
  respond_to :html

  def index
    respond_with members
  end

  def members
    @_members ||= Member.all
  end

  def update
    binding.pry
    @member = Member.find(params[:id])
    if @member.update_attributes(user_params)
      flash[:success] = "Member Updated"
    end
  end

end
