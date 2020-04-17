require 'test_helper'

module Movies
  class UpdateTest < ActiveSupport::TestCase
    test 'should update the movie name' do
      movie = movies(:star_wars)
      name = 'the lion king'
      result = ::MovieServices::Update.call(movie.id, name: name)

      assert_equal(result.name, name)
    end

    test 'should raise an exception when an invalid id is provided' do
      assert_raises(ApiNotFoundError) do
        ::MovieServices::Update.call(-1, {})
      end
    end

    test 'should not update the movie when invalid parameters are provided' do
      assert_raises(ApiInvalidRecordError) do
        movie = movies(:star_wars)

        ::MovieServices::Update.call(movie.id, name: '')
      end
    end
  end
end