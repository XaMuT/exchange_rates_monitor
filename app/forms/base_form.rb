class BaseForm
  include ActiveModel::Model
  include Virtus.model

  attr_reader :model
end
