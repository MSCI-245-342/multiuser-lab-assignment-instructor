require "application_system_test_case"

class NavigationsTest < ApplicationSystemTestCase
  # As a user who is not logged in,
  # I should be able to go to the root (homepage) and then
  # click links to take me to the Login and Signup pages.
  # From login, should be able to go signup, and back to root.
  def test_root_nav_not_logged_in
    visit root_path
    page.find(:css, 'a[href="' + login_path + '"]' ).click
    page.find(:css, 'a[href="' + signup_path + '"]' ).click
    page.find(:css, 'a[href="' + root_path + '"]' ).click
    page.find(:css, 'a[href="' + signup_path + '"]' ).click
  end
    
  # When logged in, I see some different links: List all users 
  # and logout
  def test_root_nav_logged_in
      create_user "Mark", "test@test.com", "password"
      page.find(:css, 'a[href="' + users_path + '"]' ).click
      page.find(:css, 'a[href="' + root_path + '"]' ).click
      page.find(:css, 'a[href="' + logout_path + '"]' ).click
      assert_current_path root_path
  end
    
end



