require 'test_helper'

module Purchases
  class FindOneTest < ActiveSupport::TestCase
    test 'should return an purchase' do
      john_star_wars = purchases(:john_star_wars)

      result = ::PurchaseServices::FindOne.call(john_star_wars.id)

      assert_not_nil(result)
      assert_equal(john_star_wars.id, result.id)
    end

    test 'should thrown an exception if an id that doest not exist is provided' do
      assert_raises(ApiNotFoundError) do
        ::PurchaseServices::FindOne.call(-1)
      end
    end
  end
end