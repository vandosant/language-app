class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :email, :presence => {:message => 'cannot be blank'},
            :format => { :with => /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+\z/i, :message => 'is invalid' },
            :uniqueness => { :case_sensitive => false, :message => 'is already registered' }
  validates :password, :length => { :minimum => 6, :message => 'is too short' }
  has_secure_password
end