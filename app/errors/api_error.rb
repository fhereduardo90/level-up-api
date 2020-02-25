class ApiError < StandardError
  attr_accessor :response, :title, :message, :errors, :code
 
  def initialize(options = {})
    @response = options[:response]
    @title = options[:title]
    @message = options[:message]
    @errors = parse_error(options[:errors])
    @code = options[:code] if options[:code] 
  end

  def succeed?
    false
  end

  def inspect
    "response: #{@response}, title: #{@title}, message: #{@message}, errors: #{@errors}, code: #{@code}"
  end

  private

  def parse_error(err)
    return err unless err.instance_of? ActiveModel::Errors
    err.messages.map { |k, v| { fieldname: k, messages: v } }
  end
end