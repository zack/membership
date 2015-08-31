class MembersController < ApplicationController
  helper_method :members
  respond_to :html

  def index
    respond_with members
  end

  def members
    @_members ||= Member.all
  end

end
