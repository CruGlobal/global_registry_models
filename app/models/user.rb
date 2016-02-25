## User model
class User < ActiveRecord::Base
  validates :guid, presence: true
  validates :email, presence: true
  before_validation :pull_attributes, on: :create

  def to_s
    if name.present?
      name
    elsif email.present?
      email
    else
      guid
    end
  end

  def name
    [first_name, last_name].select(&:present?).join(' ')
  end

  private

  def pull_attributes
    cas_attributes = KeyServices::User.new(email: email, guid: guid).cas_attributes
    self.guid = cas_attributes['ssoGuid']
    self.email = cas_attributes['email']
    self.first_name = cas_attributes['firstName']
    self.last_name = cas_attributes['lastName']
  rescue RestClient::ResourceNotFound
    errors.add(:email, 'is not valid') if email
    errors.add(:guid, 'is not valid') if guid
  end
end
