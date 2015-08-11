class DateValidator < ActiveModel::Validator
  def validate(record)
    if record.date_started? && record.date_ended? && record.date_started > record.date_ended
      record.errors[:date_ended] << 'date_started cannot be before dated_ended'
    end
  end
end
