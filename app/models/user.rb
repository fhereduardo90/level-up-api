class User < ApplicationRecord
  has_many :purchases
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :first_name, :last_name, presence: true
  validates :password, confirmation: true
  validate :valid_age

  before_create :generate_confirmation_token

  private

  def valid_age
    return unless birthdate

    if birthdate > 18.years.ago.to_date
      errors.add(:birthdate, I18n.t('errors.messages.age', age: 18))
    end
  end

  def confirmation_required?
    false
  end
end
