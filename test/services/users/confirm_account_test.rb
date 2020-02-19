require 'test_helper'

module Users
  class ConfirmAccountTest < ActiveSupport::TestCase
    test 'should confirm an user' do
      john = users(:john)

      result = ::UserServices::ConfirmAccount.call(john.confirmation_token)

      assert(result.confirmed?)
    end

    test 'should raise an exception if an invalid token is provided' do
      assert_raises(ApiNotFoundError) do
        ::UserServices::ConfirmAccount.call('abc')
      end
    end
  end
end