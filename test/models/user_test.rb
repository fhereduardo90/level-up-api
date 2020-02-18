require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # VALIDATIONS

  test 'should be invalid without first_name or last_name' do
    user = User.new
    user.valid?
    error = I18n.t('errors.messages.blank')

    assert_includes user.errors.messages[:first_name], error
    assert_includes user.errors.messages[:last_name], error
  end

  test 'should be valid if first_name and last_name are present' do
    user = User.new(first_name: 'john', last_name: 'papa')
    user.valid?
    error = I18n.t('errors.messages.blank')

    assert_not_includes user.errors.messages[:first_name], error
    assert_not_includes user.errors.messages[:last_name], error
  end

  test 'should be invalid without email' do
    user = User.new
    user.valid?

    assert_includes user.errors.messages[:email], I18n.t('errors.messages.blank')
  end

  test 'should be valid if email is present' do
    user = User.new(email: 'test@test.com')
    user.valid?

    assert_not_includes user.errors.messages[:email], I18n.t('errors.messages.blank')
  end

  test 'should be invalid if email has an invalid format' do
    user = User.new(email: 'test')
    user.valid?

    assert_includes user.errors.messages[:email], I18n.t('errors.messages.invalid')
  end

  test 'should be valid if email has a valid format' do
    user = User.new(email: 'test@test.com')
    user.valid?

    assert_not_includes user.errors.messages[:email], I18n.t('errors.messages.invalid')
  end

  test 'should be invalid if email is already taken' do
    john = users(:john)
    user = User.new(email: john.email)
    user.valid?

    assert_includes user.errors.messages[:email], I18n.t('errors.messages.taken')
  end

  test 'should be valid if email is not already taken' do
    user = User.new(email: "#{SecureRandom.hex(3)}@test.com" )
    user.valid?

    assert_not_includes user.errors.messages[:email], I18n.t('errors.messages.taken')
  end

  test 'should be invalid if birthdate is under 18 years old' do
    user = User.new(birthdate: 17.years.ago.to_date)
    user.valid?

    assert_includes user.errors.messages[:birthdate], I18n.t('errors.messages.age', age: 18)
  end

  test 'should be valid if birthdate is over 18 years old' do
    user = User.new(birthdate: 18.years.ago.to_date)
    user.valid?

    assert_not_includes user.errors.messages[:birthdate], I18n.t('errors.messages.age', age: 18)
  end

  test 'should be valid if birthdate is present' do
    user = User.new(birthdate: 20.years.ago.to_date)
    user.valid?

    assert_not_includes user.errors.messages[:birthdate], I18n.t('errors.messages.blank')
  end

  test 'should be valid if birthdate is empty' do
    user = User.new(birthdate: '')
    user.valid?

    assert_not_includes user.errors.messages[:birthdate], I18n.t('errors.messages.blank')
  end
end
