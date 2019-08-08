require 'test_helper'

class Users::OmniauthCallbacksControllerTest < ActionDispatch::IntegrationTest
  test "should get google_oauth2" do
    get users_omniauth_callbacks_google_oauth2_url
    assert_response :success
  end

end
