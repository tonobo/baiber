require 'test_helper'

class UserFileGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_file_group = user_file_groups(:one)
  end

  test "should get index" do
    get user_file_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_user_file_group_url
    assert_response :success
  end

  test "should create user_file_group" do
    assert_difference('UserFileGroup.count') do
      post user_file_groups_url, params: { user_file_group: { color: @user_file_group.color, desc: @user_file_group.desc, name: @user_file_group.name } }
    end

    assert_redirected_to user_file_group_url(UserFileGroup.last)
  end

  test "should show user_file_group" do
    get user_file_group_url(@user_file_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_file_group_url(@user_file_group)
    assert_response :success
  end

  test "should update user_file_group" do
    patch user_file_group_url(@user_file_group), params: { user_file_group: { color: @user_file_group.color, desc: @user_file_group.desc, name: @user_file_group.name } }
    assert_redirected_to user_file_group_url(@user_file_group)
  end

  test "should destroy user_file_group" do
    assert_difference('UserFileGroup.count', -1) do
      delete user_file_group_url(@user_file_group)
    end

    assert_redirected_to user_file_groups_url
  end
end
