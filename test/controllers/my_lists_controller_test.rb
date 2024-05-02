require "test_helper"

class MyListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @my_list = my_lists(:one)
  end

  test "should get index" do
    get my_lists_url
    assert_response :success
  end

  test "should get new" do
    get new_my_list_url
    assert_response :success
  end

  test "should create my_list" do
    assert_difference("MyList.count") do
      post my_lists_url, params: { my_list: { content_id: @my_list.content_id, semi_user_id: @my_list.semi_user_id } }
    end

    assert_redirected_to my_list_url(MyList.last)
  end

  test "should show my_list" do
    get my_list_url(@my_list)
    assert_response :success
  end

  test "should get edit" do
    get edit_my_list_url(@my_list)
    assert_response :success
  end

  test "should update my_list" do
    patch my_list_url(@my_list), params: { my_list: { content_id: @my_list.content_id, semi_user_id: @my_list.semi_user_id } }
    assert_redirected_to my_list_url(@my_list)
  end

  test "should destroy my_list" do
    assert_difference("MyList.count", -1) do
      delete my_list_url(@my_list)
    end

    assert_redirected_to my_lists_url
  end
end
