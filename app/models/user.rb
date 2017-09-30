class User < ApplicationRecord
  belongs_to :profile, polymorphic: true

  validates_presence_of :email, :password, :profile_id, :profile_type

  validates_uniqueness_of :profile_id, scope: :profile_type

  validates_length_of :email, maximum: 50
  validates_length_of :password, maximum: 50
  validates_length_of :profile_type, maximum: 10

  def generate_auth_token
    payload = { user_id: self.id }
    AuthToken.encode(payload)
  end

  def self.find_by_credentials(username, password)
    find_by(email: username, password: password)
  end
end
