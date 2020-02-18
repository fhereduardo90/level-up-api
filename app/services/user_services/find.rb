module UserServices
  class Find < ::BaseService
    ERROR_TITLE = 'User Error'.freeze

    def call
      User.all
    end
  end
end