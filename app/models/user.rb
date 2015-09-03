class User < ActiveRecord::Base

  validates :guid, presence: true

  def to_s
    case true
    when name.present?
      name
    when email.present?
      email
    else
      guid
    end
  end

  def name
    [first_name, last_name].select(&:present?).join(' ')
  end

end
