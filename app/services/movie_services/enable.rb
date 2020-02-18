module MovieServices
  class Enable < ::BaseService
    ERROR_TITLE = 'Movie Error'.freeze

    def initialize(id)
      @id = id
    end

    def call
      movie = Movie.find(@id)
      movie.update_column(:enable, true)

      movie
    end
  end
end