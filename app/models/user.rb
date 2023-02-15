class User < ApplicationRecord
    validates :email, :password_digest, :session_token, presence: true
    validates :email, uniqueness: true

    after_initialize :ensure_session_token

    has_many :notes

    # This is a method that generate a random session token
    def self.generate_session_token
        SecureRandom::urlsafe_base64
    end

    # This is a method that generate and save a session token
    def reset_session_token!
        self.session_token = User.generate_session_token
        self.save!
        self.session_token
    end

    # This is a method to check if the user have session token
    # if not, generate a new one
    def ensure_session_token
        self.session_token ||= User.generate_session_token
    end

    # This is a method to encrypt the password
    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    # This is a method to check if the password is correct
    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    # This is a method to find the user by email and password
    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)
        return nil unless user && user.is_password?(password)
        user
    end
    
    def admin?
        self.admin
    end

end

