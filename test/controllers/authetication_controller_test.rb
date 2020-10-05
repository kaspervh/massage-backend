require 'test_helper'

class AutheticationControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get authetication_login_url
    assert_response :success
  end

end
