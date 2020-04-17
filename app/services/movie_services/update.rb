module MovieServices
  class Update < ::BaseService
    ERROR_TITLE = 'Movie Error'.freeze

    def initialize(id, params = {})
      super(params)

      @id = id
    end

    def call
      movie = Movie.find(@id)

      movie.update!(@params)
      movie
    end
  end
end