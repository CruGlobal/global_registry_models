class User < ActiveRecord::Base

  validates :email, format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }, allow_blank: true
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
