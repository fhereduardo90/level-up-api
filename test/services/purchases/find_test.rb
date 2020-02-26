require 'test_helper'

module Purchases
  class FindTest < ActiveSupport::TestCase
    test 'should return a list of purchases' do
      purchases = purchases()

      result = ::PurchaseServices::Find.call

      assert_not_empty(result)
      assert_equal(result.map(&:id), purchases.map(&:id))
    end
  end
end