class BaseService
  attr_accessor :params

  def initialize(**params)
    @params = params
  end

  def self.call(...)
    new(...).call
  rescue ActiveRecord::RecordInvalid => e
    raise ApiInvalidRecordError.new(
      message: e.message,
      errors: e.record.errors
    )
  rescue ActiveRecord::RecordNotFound => e
    raise ApiNotFoundError.new(message: e.message)
  end

  def call
    raise NoImplementedError
  end
end