class User < ApplicationRecord
    validates_presence_of :name
    validates_length_of :name, maximum: 70
    
    before_save { self.email = email.downcase }    
    validates_presence_of :email
    validates_length_of :email, maximum: 255    
    validates_uniqueness_of :email, case_sensitive: false    
    validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i  
    
    has_secure_password
    validates_presence_of :password
    validates_length_of :password, minimum: 5
    
end
