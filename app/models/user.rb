class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :email, :presence => {:message => 'email cannot be blank'},
            :format => { :with => /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+\z/i, :message => 'invalid email address' },
            :uniqueness => { :case_sensitive => false, :message => 'that email is already registered' }
  validates :password, :length => { :minimum => 6, :message => 'password is too short' }
  has_secure_password
end