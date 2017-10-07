class User < ApplicationRecord
  has_secure_password # adds authentication against the bcrypt gem

  belongs_to :profile, polymorphic: true

  validates_presence_of :email, :password_digest, :profile_id, :profile_type

  validates_uniqueness_of :profile_id, scope: :profile_type

  validates_length_of :email, maximum: 50
  validates_length_of :profile_type, maximum: 10

  def generate_auth_token
    payload = { user_id: self.id }
    AuthToken.encode(payload)
  end
end
