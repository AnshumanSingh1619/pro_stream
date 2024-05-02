require "test_helper"

class SemiUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @semi_user = semi_users(:one)
  end

  test "should get index" do
    get semi_users_url
    assert_response :success
  end

  test "should get new" do
    get new_semi_user_url
    assert_response :success
  end

  test "should create semi_user" do
    assert_difference("SemiUser.count") do
      post semi_users_url, params: { semi_user: { age: @semi_user.age, date_of_birth: @semi_user.date_of_birth, name: @semi_user.name, user_id: @semi_user.user_id } }
    end

    assert_redirected_to semi_user_url(SemiUser.last)
  end

  test "should show semi_user" do
    get semi_user_url(@semi_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_semi_user_url(@semi_user)
    assert_response :success
  end

  test "should update semi_user" do
    patch semi_user_url(@semi_user), params: { semi_user: { age: @semi_user.age, date_of_birth: @semi_user.date_of_birth, name: @semi_user.name, user_id: @semi_user.user_id } }
    assert_redirected_to semi_user_url(@semi_user)
  end

  test "should destroy semi_user" do
    assert_difference("SemiUser.count", -1) do
      delete semi_user_url(@semi_user)
    end

    assert_redirected_to semi_users_url
  end
end
