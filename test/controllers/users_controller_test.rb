require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  setup do

  end

  def test_get_index
    user = create_user
    log_in_as user
    get users_url
    assert_response :success
  end

  def test_get_new
    get signup_url
    assert_response :success
  end

  def test_create_user
    assert_difference('User.count') do
      post users_url, params: { user: { name: "Test User",
        email: "t2@test.com", 
        password: "password", password_confirmation: "password" } }
    end

    assert_redirected_to root_url
  end

  def test_show_user
    user = create_user
    log_in_as user
    get user_url(user)
    assert_response :success
  end

  def test_get_edit_user
    user = create_user
    log_in_as user
    get edit_user_url(user)
    assert_response :success
  end

  def test_update_user
    user = create_user
    log_in_as user
    patch user_url(user), params: { user: { name: "Changed Name",
      email: "new@test.com", 
      password: "password", password_confirmation: "password" } }
    assert_redirected_to user_url(user)
  end

  def test_destroy_user
    user = create_user
    log_in_as user
    assert_difference('User.count', -1) do
      delete user_url(user)
    end

    assert_redirected_to users_url
  end
end
