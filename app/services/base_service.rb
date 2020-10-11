class BaseService
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

  def errors_message
    @errors.join(', ')
  end
end
