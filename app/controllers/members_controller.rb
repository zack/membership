class MembersController < ApplicationController
  helper_method :members

  def index
    respond_with members
  end

  def members
    @_members ||= Member.all
  end

  def update
    member = Member.find(params[:member][:id])
    member.update_attributes!(member_params)
    render status: 201, json: {member: member}
  end

  private

  def member_params
    puts member_update_attributes
    member_update_attributes.permit(
      :nickname,
      :phone_number,
      :forum_handle,
      :address,
      :date_of_birth,
      :wftda_id_number,
      :primary_insurance,
      :signed_wftda_waiver,
      :signed_wftda_confidentiality,
      :signed_league_bylaws,
      :purchased_wftda_insurance,
      :passed_wftda_test,
      :active,
      :google_doc_access,
      :year_joined,
      :year_left,
      :reason_left)
  end

  def member_update_attributes
    params[:member].except(:id, :updated_at, :created_at)
  end
end
