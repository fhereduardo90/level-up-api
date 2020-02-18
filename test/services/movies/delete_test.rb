require 'test_helper'

module Movies
  class Delete < ActiveSupport::TestCase
    test 'should delete a movie' do
      star_wars = movies(:star_wars)

      assert_difference('Movie.count', -1) do
        ::MovieServices::Delete.call(star_wars.id)
      end
    end

    test 'should thrown an exception if an id that doest not exist is provided' do
      assert_raises(ApiNotFoundError) do
        ::MovieServices::Delete.call(-1)
      end
    end
  end
end