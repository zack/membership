module NormalizeBlankValues
  extend ActiveSupport::Concern

  included do
    before_save :normalize_blank_values
  end

  def normalize_blank_values
    attributes.each do |column, value|
      self[column].present? || self[column] = nil
    end
  end

end
