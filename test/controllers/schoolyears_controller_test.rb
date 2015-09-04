require 'test_helper'

class SchoolyearsControllerTest < ActionController::TestCase
  setup do
    @schoolyear = schoolyears(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:schoolyears)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create schoolyear" do
    assert_difference('Schoolyear.count') do
      post :create, schoolyear: { year: @schoolyear.year }
    end

    assert_redirected_to schoolyear_path(assigns(:schoolyear))
  end

  test "should show schoolyear" do
    get :show, id: @schoolyear
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @schoolyear
    assert_response :success
  end

  test "should update schoolyear" do
    patch :update, id: @schoolyear, schoolyear: { year: @schoolyear.year }
    assert_redirected_to schoolyear_path(assigns(:schoolyear))
  end

  test "should destroy schoolyear" do
    assert_difference('Schoolyear.count', -1) do
      delete :destroy, id: @schoolyear
    end

    assert_redirected_to schoolyears_path
  end
end
