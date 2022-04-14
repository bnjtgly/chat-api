class LoginValidator
  include Helper::BasicHelper
  include ActiveModel::API

  attr_accessor(
    :email,
    :password
  )

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :required, :invalid_password

  def submit
    init
    persist!
  end

  private

  def init
    @user = User.where(email: email).first
  end

  def persist!
    return true if valid?

    false
  end

  def required
    errors.add(:email, REQUIRED_MESSAGE) if email.blank?
    errors.add(:password, REQUIRED_MESSAGE) if password.blank?
  end

  def invalid_password
    if @user
      user_password = BCrypt::Password.new(@user.encrypted_password)
      ap res = user_password == password
      errors.add(:user, INCORRECT_PASSWORD_MESSAGE) unless res
    else
      errors.add(:user, INCORRECT_PASSWORD_MESSAGE)
    end
  end
end
