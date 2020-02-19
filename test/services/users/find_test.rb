require 'test_helper'

module Users
  class FindTest < ActiveSupport::TestCase
    test 'should return a list of users' do
      users = users()

      result = ::UserServices::Find.call

      assert_not_empty(result)
      assert_equal(result.map(&:id), users.map(&:id))
    end
  end
end