require 'test_helper'

class CommitteesControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

end
