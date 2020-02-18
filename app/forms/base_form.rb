class BaseForm < Dry::Validation::Contract
  def self.call!(...)
    result = new.call(...)

    unless result.errors.empty?
      raise ApiBadRequestError.new(
        title: 'Bad Request',
        message: 'Something went wrong',
        errors: result.errors.to_h
      )
    end

    result.to_h
  end
end