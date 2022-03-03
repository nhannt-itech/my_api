require "test_helper"

class Api::V1::Auth::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get api_v1_auth_registrations_show_url
    assert_response :success
  end
end
