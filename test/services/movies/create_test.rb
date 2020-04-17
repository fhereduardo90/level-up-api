require 'test_helper'

module Movies
  class CreateTest < ActiveSupport::TestCase
    test 'should create a movie' do
      params = {
        name: 'Star Wars: The rise of skywalker',
        description: 'test description',
        stock: 10,
        enable: true,
        price: 10.99
      }
      result = nil

      assert_difference('Movie.count') do
        result = ::MovieServices::Create.call(params)
      end
      
      assert_not_nil(result.id)
    end

    test 'should not create a movie when invalid parameters are provided' do
      assert_raises(ApiInvalidRecordError) do
        ::MovieServices::Create.call({})
      end
    end
  end
end