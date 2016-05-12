class DateValidator < ActiveModel::Validator
  def validate(record)
    if record.date_started? && record.date_ended? && record.date_started > record.date_ended
      record.errors.add :date_ended, "'Date Ended' may not be before 'Date Started'"
    end
  end
end
