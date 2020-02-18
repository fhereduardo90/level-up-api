module MovieServices
  class Delete < ::BaseService
    ERROR_TITLE = 'Movie Error'.freeze

    def initialize(id)
      @id = id
    end

    def call
      movie = Movie.find(@id)

      movie.destroy!
    end
  end
end