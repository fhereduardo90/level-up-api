module UserServices
  class Update < ::BaseService
    ERROR_TITLE = 'User Error'.freeze

    def initialize(id, params = {})
      super(params)

      @id = id
    end

    def call
      user = User.find(@id)

      user.update!(@params)
      user
    end
  end
end