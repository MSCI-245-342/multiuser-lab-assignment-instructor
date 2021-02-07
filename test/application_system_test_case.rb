require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
#  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  driven_by :rack_test  
       
  def create_user(name, email, password)  
     visit signup_path
     fill_in "Name", with: name
     fill_in "Email", with: email
     fill_in "Password", with: password
     fill_in "Password confirmation", with: password
     click_on "commit"     
  end
    
    
end
