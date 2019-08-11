class User < ApplicationRecord
    has_secure_password
    has_one :profile, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :pats, dependent: :destroy
    validates_presence_of :name
    validates_uniqueness_of :email, :password_digest
    mount_uploader :avatar, AvatarUploader
    after_create :make_profile

    def make_profile
        Profile.create(:user_id => self.id)
    end

    def self.find_or_create_by_omniauth(auth)
        self.where(:email => auth["info"]["email"]).first_or_create do |user|
            user.name = auth["info"]["name"]
            user.avatar = auth["info"]["image"]
            user.password = SecureRandom.hex
        end
    end
end
