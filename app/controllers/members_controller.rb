class MembersController < ApplicationController
  IGNORED_MEMBER_KEYS = ['id', 'updated_at', 'created_at']

  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
  end
end
