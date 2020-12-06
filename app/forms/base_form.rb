class BaseForm
  include ActiveModel::Model
  TEXT_FORMAT = /\A[a-zA-Z\s]+\z/.freeze

  def initialize(params = {})
    @params = params
    super
  end
end
