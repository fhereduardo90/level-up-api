class ApiNotFoundError < ApiError
  def initialize(options = {})
    super(options.merge(code: 404))
  end
end