require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  setup do
    
  end

  def test_create_a_user
    # I defined create_user in test/application_system_test_case.rb
    # so that I could use it in any system test
    create_user "Mark", "test@test.com", "password"
    assert_text "Account created and logged in."
    assert_current_path root_path
  end
    
  def test_list_multiple_users
    create_user "Mark", "test@test.com", "password"
    create_user "Bob", "bob@test.com", "password"  
    visit users_path
    assert_text "Bob"
    assert_text "Mark"  
  end

  def test_edit_user
    password = "password"
    old_email = "test@test.com"
    create_user "Mark", old_email, password
    visit users_path
    click_on "Edit", match: :first
    new_email = "new@test.com"
    new_name = "Fred"
    fill_in "Email", with: new_email      
    fill_in "Name", with: new_name
    fill_in "Password", with: password
    fill_in "Password confirmation", with: password
    click_on "commit"
    user = User.find_by(email: new_email)
    assert_equal user.name, new_name
    assert_nil User.find_by(email: old_email)        
  end    
    
  def test_create_and_view_user
    email = "test@test.com"
    name = "Mark342Test"
    create_user name, email, "password"
    user = User.find_by( email: email )
    visit user_path(user)
    assert_text name
    assert_text email
  end
    
  def test_delete_yourself      
    email = "test@test.com"
    password = "password"      
    create_user "Mark", email, password
    user = User.find_by( email: email )
      
    visit users_path      

    # we are the only user, just click the Delete
    click_on "Delete"
      
    # we should not be in the database
    assert_nil User.find_by( email: email )      
      
    # we should be logged out
    visit users_path
    assert_text "Please log in."
    assert_current_path login_path        
            
  end
    
  def test_cannot_delete_other_user
    # have more than one user in list  
    password = "password"      
    email = "bob@test.com"
    create_user "Bob", email, password
    user = User.find_by( email: email )      
      
    # then go create account, which logs us in as another user  
    create_user "Mark", "mark@test.com", password

    visit users_path      

    # try to delete Bob
    page.find(:css, 'form[action="' + user_path(user) + '"]' ).click_on("Delete")
    assert_text "You can only edit or delete your own account."  
    
    # Make sure Bob is still in the DB
    assert_not_nil User.find_by( email: email )                          
      
    # and Bob can still login
    visit login_path
    fill_in "email", with: "bob@test.com"
    fill_in "password", with: password
    click_on "Login"
    assert_text "Logged in."                 
  end

end
