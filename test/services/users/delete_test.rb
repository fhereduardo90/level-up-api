require 'test_helper'

module Users
  class Delete < ActiveSupport::TestCase
    test 'should delete an user' do
      john = users(:john)

      assert_difference('User.count', -1) do
        ::UserServices::Delete.call(john.id)
      end
    end

    test 'should thrown an exception if an id that doest not exist is provided' do
      assert_raises(ApiNotFoundError) do
        ::UserServices::Delete.call(-1)
      end
    end
  end
end