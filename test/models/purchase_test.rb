require 'test_helper'

class PurchaseTest < ActiveSupport::TestCase
  test 'should not be valid with a quantity less than 1' do
    purchase = Purchase.new(quantity: 0)
    purchase.valid?

    assert_includes purchase.errors.messages[:quantity], I18n.t('errors.messages.greater_than', count: 0)
  end

  test 'should be valid with a quantity greater than 0' do
    purchase = Purchase.new(quantity: 1)
    purchase.valid?

    assert_not_includes purchase.errors.messages[:quantity], I18n.t('errors.messages.greater_than', count: 0)
  end

  test 'should not be valid without an associated user' do
    purchase = Purchase.new
    purchase.valid?

    assert_includes purchase.errors.messages[:user], I18n.t('errors.messages.required')
  end

  test 'should be valid if an user is provided' do
    john = users(:john)
    purchase = Purchase.new(user: john)
    purchase.valid?

    assert_not_includes purchase.errors.messages[:user], I18n.t('errors.messages.required')
  end

  test 'should not be valid without an associated movie' do
    purchase = Purchase.new
    purchase.valid?

    assert_includes purchase.errors.messages[:movie], I18n.t('errors.messages.required')
  end

  test 'should be valid if a movie is provided' do
    star_wars = movies(:star_wars)
    purchase = Purchase.new(movie: star_wars)
    purchase.valid?

    assert_not_includes purchase.errors.messages[:movie], I18n.t('errors.messages.required')
  end

  test 'should not be valid if price is less than or equal to 0' do
    purchase = Purchase.new(price: 0)
    purchase.valid?

    assert_includes purchase.errors.messages[:price], I18n.t('errors.messages.greater_than', count: 0)
  end

  test 'should be valid if price is greater than 0' do
    purchase = Purchase.new(price: 1)
    purchase.valid?

    assert_not_includes purchase.errors.messages[:price], I18n.t('errors.messages.greater_than', count: 0)
  end

  test 'should not be valid if price is not a number' do
    purchase = Purchase.new(price: '')
    purchase.valid?

    assert_includes purchase.errors.messages[:price], I18n.t('errors.messages.not_a_number')
  end

  test 'should be valid if price is a number' do
    purchase = Purchase.new(price: 2)
    purchase.valid?

    assert_not_includes purchase.errors.messages[:price], I18n.t('errors.messages.not_a_number')
  end
end
