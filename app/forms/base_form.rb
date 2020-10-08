class BaseForm
  include ActiveModel::Model

  def initialize(params = {})
    @params = params
    super
  end
end
