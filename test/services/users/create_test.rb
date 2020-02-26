require 'test_helper'

module Users
  class CreateTest < ActiveSupport::TestCase
    test 'should create a user' do
      password = Devise::Encryptor.digest(User, 'password')
      params = {
        first_name: 'John',
        last_name: 'Papa',
        birthdate: '1990-10-13',
        email: 'testuser1@test.com',
        password: password,
        password_confirmation: password
      }
      result = nil

      assert_difference('User.count') do
        result = ::UserServices::Create.call(params)
      end

      assert_not_nil(result.id)
    end

    test 'should not create an user when invalid parameters are provided' do
      assert_raises(ApiInvalidRecordError) do
        ::UserServices::Create.call({})
      end
    end
  end
end