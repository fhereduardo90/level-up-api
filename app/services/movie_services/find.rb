module MovieServices
  class Find < ::BaseService
    ERROR_TITLE = 'Movie Error'.freeze

    def call
      Movie.all
    end
  end
end