require 'test_helper'

module Movies
  class FindTest < ActiveSupport::TestCase
    test 'should return a list of movies' do
      movies = movies()

      result = ::MovieServices::Find.call

      assert_not_empty(result)
      assert_equal(result.map(&:id), movies.map(&:id))
    end
  end
end