require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase

  # https://stackoverflow.com/questions/88311/how-to-generate-a-random-string-in-ruby
  def random_string(size = 12)
    charset = %w{ a b c d e f g h i j k l m n o p q r s t u v w x y z }
    (0...size).map{ charset.to_a[rand(charset.size)] }.join
  end

  setup do
    Capybara.current_driver = :mechanize  
    Capybara.app_host = 'http://multiuser-msmucker.herokuapp.com/'    
    Capybara.run_server = false        

    len = 10
    @user_name_1 = random_string
    @email_1 = random_string + "@" + random_string + ".com" 
    @user_name_2 = random_string
    @email_2 = random_string + "@" + random_string + ".com" 
    @password = "password"

  end

  def test_run_all_in_order
    list_multiple_users
  end

  def list_multiple_users
    create_user @user_name_1, @email_1, @password
    assert_text "Account created and logged in."
    assert_current_path root_path
    create_user @user_name_2, @email_2, @password  
    assert_text "Account created and logged in."
    assert_current_path root_path
    visit users_path
    assert_text @user_name_1
    assert_text @user_name_2
  end

  def edit_user
    visit users_path
    click_on "Edit", match: :first
    new_email = random_string + "@" + random_string + ".com" 
    new_name = random_string
    fill_in "Email", with: new_email      
    fill_in "Name", with: new_name
    fill_in "Password", with: @password
    fill_in "Password confirmation", with: @password
    click_on "commit"
    visit users_path
    assert_text @new_name 
  end    
    
end
