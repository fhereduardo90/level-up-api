require 'test_helper'

module Movies
  class FindOneTest < ActiveSupport::TestCase
    test 'should return a movie' do
      star_wars = movies(:star_wars)

      result = ::MovieServices::FindOne.call(star_wars.id)

      assert_not_nil(result)
      assert_equal(star_wars.id, result.id)
    end

    test 'should thrown an exception if an id that doest not exist is provided' do
      assert_raises(ApiNotFoundError) do
        ::MovieServices::FindOne.call(-1)
      end
    end
  end
end