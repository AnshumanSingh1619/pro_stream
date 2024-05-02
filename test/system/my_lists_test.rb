require "application_system_test_case"

class MyListsTest < ApplicationSystemTestCase
  setup do
    @my_list = my_lists(:one)
  end

  test "visiting the index" do
    visit my_lists_url
    assert_selector "h1", text: "My lists"
  end

  test "should create my list" do
    visit my_lists_url
    click_on "New my list"

    fill_in "Content", with: @my_list.content_id
    fill_in "Semi user", with: @my_list.semi_user_id
    click_on "Create My list"

    assert_text "My list was successfully created"
    click_on "Back"
  end

  test "should update My list" do
    visit my_list_url(@my_list)
    click_on "Edit this my list", match: :first

    fill_in "Content", with: @my_list.content_id
    fill_in "Semi user", with: @my_list.semi_user_id
    click_on "Update My list"

    assert_text "My list was successfully updated"
    click_on "Back"
  end

  test "should destroy My list" do
    visit my_list_url(@my_list)
    click_on "Destroy this my list", match: :first

    assert_text "My list was successfully destroyed"
  end
end
