require 'test_helper'

class UserTest < ActiveSupport::TestCase
    
def test_email_must_be_unique
    user1 = User.new(name: "Example User", 
       email: "user@example.com" )
    user1.save! # if fails, an error is raised
    user2 = User.new(name: "Example User", 
       email: "user@Example.com" ) # also check downcase
    assert_not user2.valid?     
end
    
end
