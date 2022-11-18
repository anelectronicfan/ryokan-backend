require 'test_helper'

class ListControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get list_list_url
    assert_response :success
  end

end
