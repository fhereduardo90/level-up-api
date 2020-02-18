module UserServices
  class FindOne < ::BaseService
    ERROR_TITLE = 'User Error'.freeze

    def initialize(id)
      @id = id
    end

    def call
      User.find(@id)
    end
  end
end