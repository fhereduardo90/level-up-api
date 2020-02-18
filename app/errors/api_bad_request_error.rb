class ApiBadRequestError < StandardError
  def initialize(options = {})
    @response = options[:response]
    @title = options[:title]
    @message = options[:message]
    @errors = parse_error(options[:errors])
    @code = 400
  end

  def succeed?
    false
  end

  def inspect
    "response: #{@response}, title: #{@title}, message: #{@message}, errors: #{@errors}, code: #{@code}"
  end

  def to_s
    self.inspect
  end

  private

  def parse_error(errors = {})
    return [] if errors.blank?
    errors.map { |k, v| { fieldname: k, messages: v } }
  end
end