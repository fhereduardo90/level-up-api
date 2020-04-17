require 'test_helper'

module Purchases
  class BuyTest < ActiveSupport::TestCase
    test 'should create a purchase' do
      star_wars = movies(:star_wars)
      params = {
        movie_id: star_wars.id,
        quantity: 3
      }
      result = nil

      assert_difference('Purchase.count') do
        result = ::PurchaseServices::Buy.call(users(:john), params)
      end

      assert_not_nil(result.id)
      assert_equal(result.quantity, params[:quantity])
    end

    test 'should reduce the movie stock when a purchase is made' do
      star_wars = movies(:star_wars)
      params = {
        movie_id: star_wars.id,
        quantity: 3
      }
      stock = star_wars.stock

      assert_changes -> { star_wars.stock }, from: stock, to: stock - params[:quantity] do
        ::PurchaseServices::Buy.call(users(:john), params)
        star_wars.reload
      end
    end

    test 'should not create a purchase when the movie does not exist' do
      exception = assert_raises(ApiNotFoundError) do
        ::PurchaseServices::Buy.call(users(:john), movie_id: -1, quantity: 3)
      end

      assert_equal(
        exception.message,
        I18n.t(
          'errors.messages.record_not_found',
          klass: Movie.name,
          field: 'id',
          value: -1
        )
      )
    end

    test 'should not create a purchase when the movie is disabled' do
      movie = movies(:disable)

      exception = assert_raises(ApiNotFoundError) do
        ::PurchaseServices::Buy.call(users(:john), movie_id: movie.id, quantity: 3)
      end

      assert_equal(
        exception.message,
        I18n.t(
          'errors.messages.record_not_found',
          klass: Movie.name,
          field: 'id',
          value: movie.id
        )
      )
    end

    test 'should not create a purchase when quantity is greater than movie stock' do
      star_wars = movies(:star_wars)
      params = {
        movie_id: star_wars.id,
        quantity: star_wars.stock + 1
      }

      exception = assert_raises(ApiError) do
        ::PurchaseServices::Buy.call(users(:john), params)
      end

      assert_equal exception.message, I18n.t('errors.messages.out_stock')
      assert_no_changes -> { star_wars.stock } do
        star_wars.reload
      end
    end
  end
end