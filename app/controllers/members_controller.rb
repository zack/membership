class MembersController < ApplicationController
  helper_method :members

  def index
    respond_with members
  end

  def members
    @_members ||= Member.all
  end

  def create
    member = Member.create()
    member.update_attributes!(member_params)
    member.save
    render status: 201, json: {member: member}
  end

  def update
    member = Member.find(params[:member][:id])
    member.update_attributes!(member_params)
    render status: 201, json: {member: member}
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
      :nickname,
      :passed_wftda_test,
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
