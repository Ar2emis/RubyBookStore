class BaseService
  attr_reader :errors

  def self.call(**kwargs)
    service = new(kwargs)
    service.call
    service
  end

  def success?
    @errors.empty?
  end

  def initialize(**_)
    @errors = []
  end
end
