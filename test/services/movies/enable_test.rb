require 'test_helper'

module Movies
  class EnableTest < ActiveSupport::TestCase
    test 'should enable a movie' do
      movie = movies(:disable)

      result = ::MovieServices::Enable.call(movie.id)

      assert_not_nil(result)
      assert(result.enable)
    end

    test 'should thrown an exception if an id that doest not exist is provided' do
      assert_raises(ApiNotFoundError) do
        ::MovieServices::Enable.call(-1)
      end
    end
  end
end