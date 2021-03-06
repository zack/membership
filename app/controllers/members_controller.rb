class MembersController < ApplicationController
  helper_method :members
  before_action :user_is_admin?, only: [:create, :update]

  def index
    respond_with members
  end

  def user_is_admin?
    unless current_user.username == 'admin'
      redirect_to root_path
    end
  end

  def members
    @_members ||= Member.all
  end

  def create
    member = Member.create()
    member.update_attributes!(member_params)
    member.save
    render status: 201, json: member
  end

  def update
    member = Member.find(params[:member][:id])
    member.update_attributes!(member_params)
    render status: 201, json: member
  end

  private

  def member_params
    puts params
    params[:member].permit(
      :active,
      :address,
      :date_of_birth,
      :forum_handle,
      :google_doc_access,
      :government_name,
      :volunteer,
      :nickname,
      :passed_wftda_test,
      :official,
      :phone_number,
      :primary_insurance,
      :purchased_wftda_insurance,
      :reason_left,
      :signed_league_bylaws,
      :signed_wftda_confidentiality,
      :signed_wftda_waiver,
      :street_name,
      :wftda_id_number,
      :year_joined,
      :year_left)
  end
end
