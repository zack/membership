class EmergencyContactsController < ApplicationController
  helper_method :emergency_contacts

  def index
    respond_with emergency_contacts
  end

  def emergency_contacts
    @_emergency_contacts ||= EmergencyContact.all
  end

  def update
    emergency_contact = EmergencyContact.find(params[:emergency_contact][:id])
    emergency_contact.update_attributes!(emergency_contact_params)
    render status: 201, json: emergency_contact
  end

  private

  def emergency_contact_params
    params[:emergency_contact].permit(
      :name,
      :phone_number,
      :relationship,
      :address)
  end
end
