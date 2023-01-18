# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  username      :string           not null
#  email         :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  favorite_coin :string           not null
#  age           :integer          not null
#
class User < ApplicationRecord  
    validates :username, :email, :session_token, presence: true, uniqueness: true # when a username is created it must have a username, else it will fail 
    validates :password_digest, presence: true 
    validates :password, length: { minimum: 6 }, allow_nil: true 
    # allow_nil: true is necessary for non sign in pages to make changes with a user 
    attr_reader :password 

    after_initialize :ensure_session_token # anytime you initialize an instance, the method enure_session_token will run after .new 
    #before_validation :ensure_session_token # will run the method before .save, both work 

    def self.find_by_credentials(username, password)
        # return user if username and password is legit 
        user = User.find_by(username: username)
        if user && user.check_password?(password)
            return user 
        else
            return nil 
        end 
    end 

    def check_password?(password)
        # turnn string from db into object 
        password_object = BCrypt::Password.new(self.password_digest) 
        # is_password? is a BCrypt method 
        password_object.is_password?(password)
    end
# CREATE PASSWORD -----------------------------------------------------------------------------------------------------------------
    def password=(password)
        # create a password digest and save the password to an instance variable 
        # the instance variable allows our password validations to work 
        self.password_digest = BCrypt::Password.create(password) #BCrypt gives you a random string like "2v0833fn2vr$1238fbaEwAJF"
        @password = password 
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token 

    end

    # need to create a random string to pass session token validations 
    def ensure_session_token 
        self.session_token ||= SecureRandom::urlsafe_base64 #SecureRandom also gives you a random string "bNLi318f-avBrahfu2" 
    end


    has_many :chirps,
        primary_key: :id,
        foreign_key: :author_id, 
        class_name: :Chirp,
        dependent: :destroy 

    has_many :likes, 
        primary_keys: :id,
        foreign_keys: :liker_id,
        class_name: :Like,
        dependent: :destroy

    has_many :liked_chirps,
        through: :likes,
        source: :chirp,
        dependent: :destory 
end


