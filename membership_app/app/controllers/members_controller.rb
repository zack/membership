class MembersController < ApplicationController
  attr_accessor :legal_name, :derby_name, :email_address

  def index
    @members = Member.all
  end

  def new
    @member = Member.new
  end

  def edit
    @member = Member.find(params[:id])
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      flash[:success] = 'Member Created'
      redirect_to @member
    else
      render 'new'
    end
  end

  def show
    @member = Member.find(params[:id])
  end

  private

    def member_params
      params.require(:user).permit(:legal_name, :derby_name, :email_address)
    end
end
