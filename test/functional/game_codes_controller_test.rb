require 'test_helper'

class GameCodesControllerTest < ActionController::TestCase
  setup do
    @game_code = game_codes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:game_codes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game_code" do
    assert_difference('GameCode.count') do
      post :create, game_code: { name: @game_code.name }
    end

    assert_redirected_to game_code_path(assigns(:game_code))
  end

  test "should show game_code" do
    get :show, id: @game_code
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game_code
    assert_response :success
  end

  test "should update game_code" do
    put :update, id: @game_code, game_code: { name: @game_code.name }
    assert_redirected_to game_code_path(assigns(:game_code))
  end

  test "should destroy game_code" do
    assert_difference('GameCode.count', -1) do
      delete :destroy, id: @game_code
    end

    assert_redirected_to game_codes_path
  end
end
