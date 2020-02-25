require 'test_helper'

module Purchases
  class BuyTest < ActiveSupport::TestCase
    test 'should create a purchase' do
      star_wars = movies(:star_wars)
      stock = star_wars.stock
      quantity = 3
      result = nil

      assert_difference('Purchase.count') do
        result = ::PurchaseServices::Buy.call(users(:john), star_wars.id, quantity)
      end

      assert_not_nil(result.id)
      assert_equal(result.quantity, quantity)
    end

    test 'should reduce the movie stock when a purchase is made' do
      star_wars = movies(:star_wars)
      stock = star_wars.stock
      quantity = 3  

      assert_changes -> { star_wars.stock }, from: stock, to: stock - quantity do
        ::PurchaseServices::Buy.call(users(:john), star_wars.id, quantity)
        star_wars.reload
      end
    end

    test 'should not create a purchase when the movie does not exist' do
      exception = assert_raises(ApiError) do
        ::PurchaseServices::Buy.call(users(:john), -1, 3)
      end

      assert_equal exception.message, I18n.t('errors.messages.record_not_found', klass: Movie.name, field: 'id', value: -1)
    end

    test 'should not create a purchase when quantity is greater than movie stock' do
      star_wars = movies(:star_wars)
      quantity = star_wars.stock + 1

      exception = assert_raises(ApiError) do
        ::PurchaseServices::Buy.call(users(:john), star_wars.id, quantity)
      end

      assert_equal exception.message, I18n.t('errors.messages.out_stock')
      assert_no_changes -> { star_wars.stock } do
        star_wars.reload
      end
    end
  end
end