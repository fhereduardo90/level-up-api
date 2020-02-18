module UserServices
  class Delete < ::BaseService
    ERROR_TITLE = 'User Error'.freeze

    def initialize(id)
      @id = id
    end

    def call
      user = User.find(@id)

      user.destroy!
    end
  end
end