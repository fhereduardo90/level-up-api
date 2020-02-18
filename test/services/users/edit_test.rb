require 'test_helper'

module Users
  class EditTest < ActiveSupport::TestCase
    test 'should update the user email' do
      user = users(:john)
      email = "#{SecureRandom.hex(3)}@test.com"
      result = ::UserServices::Edit.call(user.id, { email: email })

      assert_equal(result.email, email)
    end

    test 'should not update the user when an invalid id is provided' do
      assert_raises(ApiNotFoundError) do
        ::UserServices::Edit.call(-1, {})
      end
    end

    test 'should not update the user when invalid parameters are provided' do
      assert_raises(ApiInvalidRecordError) do
        user = users(:john)

        ::UserServices::Edit.call(user.id, email: '')
      end
    end
  end
end