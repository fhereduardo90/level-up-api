module PurchaseServices
  class Buy < ::BaseService
    ERROR_TITLE = 'Purchase Error'.freeze

    def initialize(user, movie_id:, quantity:)
      @user = user
      @movie_id = movie_id
      @quantity = quantity
    end

    def call
      unless movie = Movie.find_by(id: @movie_id, enable: true)
        raise ApiNotFoundError.new(
          title: ERROR_TITLE,
          message: I18n.t(
            'errors.messages.record_not_found',
            klass: Movie.name, field: 'id', value: @movie_id
          )
        )
      end

      raise ApiError.new(
        title: ERROR_TITLE,
        message: I18n.t('errors.messages.out_stock')
      ) if movie.stock < @quantity

      ActiveRecord::Base.transaction do
        movie.decrement!(:stock, @quantity)
        Purchase.create!(
          user: @user,
          movie: movie,
          price: movie.price,
          quantity: @quantity
        )
      end
    end
  end
end