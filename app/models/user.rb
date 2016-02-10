## User model
class User < ActiveRecord::Base
  validates :guid, presence: true, unless: -> (user) { user.email.present? }
  validates :email, presence: true, unless: -> (user) { user.guid.present? }

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
end
