module MovieServices
  class Disable < ::BaseService
    ERROR_TITLE = 'Movie Error'.freeze

    def initialize(id)
      @id = id
    end

    def call
      movie = Movie.find(@id)
      movie.update_column(:enable, false)

      movie
    end
  end
end