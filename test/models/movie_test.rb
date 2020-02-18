require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  # Validations
  test 'should not be valid without name' do
    movie = Movie.new
    movie.valid?

    assert_includes movie.errors.messages[:name], I18n.t('errors.messages.blank')
  end

  test 'should be valid if name is present' do
    movie = movies('star_wars')
    movie.valid?

    assert_not_includes movie.errors.messages[:name], I18n.t('errors.messages.blank')
  end

  test 'should not be valid if stock is less than 0' do
    movie = Movie.new(stock: -1)
    movie.valid?

    assert_includes movie.errors.messages[:stock], I18n.t('errors.messages.greater_than_or_equal_to', count: 0)
  end

  test 'should be valid if stock is equal or greater than 0' do
    movie1 = Movie.new(stock: 0)
    movie2 = Movie.new(stock: 1)
    movie1.valid?
    movie2.valid?
    error = I18n.t('errors.messages.greater_than_or_equal_to', count: 0)

    assert_not_includes movie1.errors.messages[:stock], error
    assert_not_includes movie2.errors.messages[:stock], error
  end

  test 'should not be valid if visible is either empty or nil' do
    movie1 = Movie.new(visible: '')
    movie2 = Movie.new(visible: nil)
    movie1.valid?
    movie2.valid?
    error = I18n.t('errors.messages.inclusion')

    assert_includes movie1.errors.messages[:visible], error
    assert_includes movie2.errors.messages[:visible], error
  end

  test 'should be valid if visible is true or false' do
    movie1 = Movie.new(visible: true)
    movie2 = Movie.new(visible: false)
    movie1.valid?
    movie2.valid?
    error = I18n.t('errors.messages.inclusion')

    assert_not_includes movie1.errors.messages[:visible], error
    assert_not_includes movie2.errors.messages[:visible], error
  end

  test 'should not be valid if description length is greater than 255 characters' do
    movie = Movie.new(description: 'a' * 256)
    movie.valid?

    assert_includes movie.errors.messages[:description], I18n.t('errors.messages.too_long', count: 255)
  end

  test 'should be valid if description length is empty, equal or less than 255 characters' do
    movie1 = Movie.new
    movie2 = Movie.new(description: 'a' * 255)
    movie3 = Movie.new(description: 'a' * 10)
    error = I18n.t('errors.messages.too_long', count: 255)

    assert_not_includes movie1.errors.messages[:description], error
    assert_not_includes movie2.errors.messages[:description], error
    assert_not_includes movie3.errors.messages[:description], error
  end
end
