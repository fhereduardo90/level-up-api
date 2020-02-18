require 'test_helper'

module Movies
  class DisableTest < ActiveSupport::TestCase
    test 'should disable a movie' do
      movie = movies(:enable)

      result = ::MovieServices::Disable.call(movie.id)

      assert_not_nil(result)
      assert_not(result.enable)
    end

    test 'should thrown an exception if an id that doest not exist is provided' do
      assert_raises(ApiNotFoundError) do
        ::MovieServices::Disable.call(-1)
      end
    end
  end
end