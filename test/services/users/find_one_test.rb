require 'test_helper'

module Users
  class FindOneTest < ActiveSupport::TestCase
    test 'should return an user' do
      john = users(:john)

      result = ::UserServices::FindOne.call(john.id)

      assert_not_nil(result)
      assert_equal(john.id, result.id)
    end

    test 'should thrown an exception if an id that doest not exist is provided' do
      assert_raises(ApiNotFoundError) do
        ::UserServices::FindOne.call(-1)
      end
    end
  end
end