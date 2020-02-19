module UserServices
  class ConfirmAccount < ::BaseService
    ERROR_TITLE = 'User Error'.freeze

    def initialize(token)
      @token = token
    end

    def call
      user = User.confirm_by_token(@token)

      raise ApiNotFoundError.new(
        title: ERROR_TITLE,
        message: 'El enlace ya no es válido'
      ) unless user.persisted?

      user
    end
  end
end