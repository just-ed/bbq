class User < ApplicationRecord
  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create

  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook vkontakte]

  has_many :events
  has_many :comments, dependent: :destroy
  has_many :subscriptions

  validates :name, presence: true, length: {maximum: 35}

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def self.find_for_facebook_oauth(access_token)
    find_or_create_from_email_provider_url_name(
      email: access_token.info.email,
      provider: access_token.provider,
      url: "https://facebook.com/#{access_token.extra.raw_info.id}",
      name: access_token.info.name,
      remote_avatar_url: "#{access_token.info.image}?type=large"
    )
  end

  def self.find_for_vkontakte_oauth(access_token)
    find_or_create_from_email_provider_url_name(
      email: access_token.info.email,
      provider: access_token.provider,
      url: access_token.info.urls.Vkontakte,
      name: access_token.info.name,
    remote_avatar_url: access_token.extra.raw_info.photo_400_orig
    )
  end

  private

  def self.find_or_create_from_email_provider_url_name(email:, provider:, url:, remote_avatar_url:, name:)
    return nil if email.nil?

    user = find_by(email: email)
    return user if user.present?

    where(url: url, provider: provider).first_or_create! do |user|
      user.email = email
      user.password = Devise.friendly_token.first(16)
      user.name = name
      user.remote_avatar_url = remote_avatar_url
    end
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: email).update_all(user_id: id)
  end

  def set_name
    self.name = "Комрад №#{rand(999)}" if name.blank?
  end
end
