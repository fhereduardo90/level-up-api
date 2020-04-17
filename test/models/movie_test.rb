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

  test 'should not be valid if stock is not a number' do
    movie = Movie.new(stock: '')
    movie.valid?

    assert_includes movie.errors.messages[:stock], I18n.t('errors.messages.not_a_number')
  end

  test 'should be valid if stock is a number' do
    movie = Movie.new(stock: 2)
    movie.valid?

    assert_not_includes movie.errors.messages[:stock], I18n.t('errors.messages.not_a_number')
  end

  test 'should not be valid if stock is not an integer' do
    movie = Movie.new(stock: 2.22)
    movie.valid?

    assert_includes movie.errors.messages[:stock], I18n.t('errors.messages.not_an_integer')
  end

  test 'should be valid if stock is a valid integer' do
    movie = Movie.new(stock: 1)
    movie.valid?

    assert_not_includes movie.errors.messages[:stock], I18n.t('errors.messages.not_an_integer')
  end

  test 'should not be valid if enable is either empty or nil' do
    movie1 = Movie.new(enable: '')
    movie2 = Movie.new(enable: nil)
    movie1.valid?
    movie2.valid?
    error = I18n.t('errors.messages.inclusion')

    assert_includes movie1.errors.messages[:enable], error
    assert_includes movie2.errors.messages[:enable], error
  end

  test 'should be valid if enable is true or false' do
    movie1 = Movie.new(enable: true)
    movie2 = Movie.new(enable: false)
    movie1.valid?
    movie2.valid?
    error = I18n.t('errors.messages.inclusion')

    assert_not_includes movie1.errors.messages[:enable], error
    assert_not_includes movie2.errors.messages[:enable], error
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
  
  test 'should be invalid if name is already taken' do
    star_wars = movies(:star_wars)
    movie = Movie.new(name: star_wars.name)
    movie.valid?

    assert_includes movie.errors.messages[:name], I18n.t('errors.messages.taken')
  end

  test 'should be valid if name is not already taken' do
    movie = Movie.new(name: SecureRandom.hex(3))
    movie.valid?

    assert_not_includes movie.errors.messages[:name], I18n.t('errors.messages.taken')
  end

  test 'should not be valid if price is less than or equal to 0' do
    movie = Movie.new(price: 0)
    movie.valid?

    assert_includes movie.errors.messages[:price], I18n.t('errors.messages.greater_than', count: 0)
  end

  test 'should be valid if price is greater than 0' do
    movie = Movie.new(price: 1)
    movie.valid?

    assert_not_includes movie.errors.messages[:price], I18n.t('errors.messages.greater_than', count: 0)
  end

  test 'should not be valid if price is not a number' do
    movie = Movie.new(price: '')
    movie.valid?

    assert_includes movie.errors.messages[:price], I18n.t('errors.messages.not_a_number')
  end

  test 'should be valid if price is a number' do
    movie = Movie.new(price: 2)
    movie.valid?

    assert_not_includes movie.errors.messages[:price], I18n.t('errors.messages.not_a_number')
  end

  test 'should not be valid if rental price is less than or equal to 0' do
    movie = Movie.new(rental_price: 0)
    movie.valid?

    assert_includes movie.errors.messages[:rental_price], I18n.t('errors.messages.greater_than', count: 0)
  end

  test 'should be valid if rental price is greater than 0' do
    movie = Movie.new(rental_price: 1)
    movie.valid?

    assert_not_includes movie.errors.messages[:rental_price], I18n.t('errors.messages.greater_than', count: 0)
  end

  test 'should not be valid if rental price is not a number' do
    movie = Movie.new(rental_price: '')
    movie.valid?

    assert_includes movie.errors.messages[:rental_price], I18n.t('errors.messages.not_a_number')
  end

  test 'should be valid if rental price is a number' do
    movie = Movie.new(rental_price: 2)
    movie.valid?

    assert_not_includes movie.errors.messages[:rental_price], I18n.t('errors.messages.not_a_number')
  end
end
