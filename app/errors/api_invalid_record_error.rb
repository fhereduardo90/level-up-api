class ApiInvalidRecordError < ApiError
  def initialize(options = {})
    super(options.merge(code: 422))
  end
end