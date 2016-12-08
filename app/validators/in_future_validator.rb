class InFutureValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.present? && value.future?
      record.errors.add(attribute, :not_in_future)
    end
  end
end
