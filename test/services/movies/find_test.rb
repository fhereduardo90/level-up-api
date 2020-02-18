require 'test_helper'

module Movies
  class FindTest < ActiveSupport::TestCase
    test 'should return a list of movies' do
      star_wars = movies(:star_wars)
      lion_king = movies(:lion_king)

      result = ::MovieServices::Find.call

      assert_not_empty(result)
      assert_equal(result.map(&:id), [star_wars.id, lion_king.id])
    end
  end
end