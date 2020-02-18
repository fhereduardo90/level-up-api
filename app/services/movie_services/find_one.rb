module MovieServices
  class FindOne < ::BaseService
    ERROR_TITLE = 'Movie Error'.freeze

    def initialize(id)
      @id = id
    end

    def call
      Movie.find(@id)
    end
  end
end