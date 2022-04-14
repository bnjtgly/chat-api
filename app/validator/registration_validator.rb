class RegistrationValidator
  include Helper::BasicHelper
  include ActiveModel::API

  attr_accessor(
    :email,
    :password,
    :password_confirmation,
    :first_name,
    :last_name
  )

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_confirmation_of :password
  validate :email_exist, :required, :password_requirements

  def submit
    persist!
  end

  private
  def persist!
    return true if valid?

    false
  end

  def required
    errors.add(:email, REQUIRED_MESSAGE) if email.blank?
    errors.add(:password, REQUIRED_MESSAGE) if password.blank?
    errors.add(:password_confirmation, REQUIRED_MESSAGE) if password_confirmation.blank?
    errors.add(:first_name, REQUIRED_MESSAGE) if first_name.blank?
    errors.add(:last_name, REQUIRED_MESSAGE) if last_name.blank?
  end

  def password_requirements
    return if password.blank? || password =~ /\A(?=.{6,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/x

    errors.add(:password, PASSWORD_REQUIREMENTS_MESSAGE)
  end

  def email_exist
    errors.add(:email, EMAIL_EXIST_MESSAGE) if User.exists?(email: email.try(:downcase))
  end
end
