module UserServices
  class Create < ::BaseService
    ERROR_TITLE = 'User Error'.freeze

    def call
      User.create!(@params)
    end
  end
end