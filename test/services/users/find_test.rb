require 'test_helper'

module Users
  class FindTest < ActiveSupport::TestCase
    test 'should return a list of users' do
      john = users(:john)
      dan = users(:dan)

      result = ::UserServices::Find.call

      assert_not_empty(result)
      assert_equal(result.map(&:id), [john.id, dan.id])
    end
  end
end