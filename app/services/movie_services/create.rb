module MovieServices
  class Create < ::BaseService
    ERROR_TITLE = 'Movie Error'.freeze

    def call
      Movie.create!(@params)
    end
  end
end