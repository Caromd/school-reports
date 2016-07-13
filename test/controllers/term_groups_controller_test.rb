require 'test_helper'

class TermGroupsControllerTest < ActionController::TestCase
  setup do
    @term_group = term_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:term_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create term_group" do
    assert_difference('TermGroup.count') do
      post :create, term_group: { name: @term_group.name, term_id: @term_group.term_id }
    end

    assert_redirected_to term_group_path(assigns(:term_group))
  end

  test "should show term_group" do
    get :show, id: @term_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @term_group
    assert_response :success
  end

  test "should update term_group" do
    patch :update, id: @term_group, term_group: { name: @term_group.name, term_id: @term_group.term_id }
    assert_redirected_to term_group_path(assigns(:term_group))
  end

  test "should destroy term_group" do
    assert_difference('TermGroup.count', -1) do
      delete :destroy, id: @term_group
    end

    assert_redirected_to term_groups_path
  end
end
