require "application_system_test_case"

class SemiUsersTest < ApplicationSystemTestCase
  setup do
    @semi_user = semi_users(:one)
  end

  test "visiting the index" do
    visit semi_users_url
    assert_selector "h1", text: "Semi users"
  end

  test "should create semi user" do
    visit semi_users_url
    click_on "New semi user"

    fill_in "Age", with: @semi_user.age
    fill_in "Date of birth", with: @semi_user.date_of_birth
    fill_in "Name", with: @semi_user.name
    fill_in "User", with: @semi_user.user_id
    click_on "Create Semi user"

    assert_text "Semi user was successfully created"
    click_on "Back"
  end

  test "should update Semi user" do
    visit semi_user_url(@semi_user)
    click_on "Edit this semi user", match: :first

    fill_in "Age", with: @semi_user.age
    fill_in "Date of birth", with: @semi_user.date_of_birth
    fill_in "Name", with: @semi_user.name
    fill_in "User", with: @semi_user.user_id
    click_on "Update Semi user"

    assert_text "Semi user was successfully updated"
    click_on "Back"
  end

  test "should destroy Semi user" do
    visit semi_user_url(@semi_user)
    click_on "Destroy this semi user", match: :first

    assert_text "Semi user was successfully destroyed"
  end
end
