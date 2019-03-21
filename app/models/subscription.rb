class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true, unless: -> { user.present? }
  validates :user_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, unless: -> { user.present? }
  validates :user, uniqueness: {scope: :event_id}, if: -> { user.present? }
  validates :user_email, uniqueness: {scope: :event_id}, unless: -> { user.present? }
  validate :email_availability, unless: -> { user.present? }

  def user_name
    user.present? ? user.name : super
  end

  def user_email
    user.present? ? user.email : super
  end

  def email_availability
    errors.add(:user_email, :unavailable) if User.exists?(email: user_email)
  end
end
