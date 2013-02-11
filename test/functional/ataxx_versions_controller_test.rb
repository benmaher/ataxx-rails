require 'test_helper'

class AtaxxVersionsControllerTest < ActionController::TestCase
  setup do
    @ataxx_version = ataxx_versions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ataxx_versions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ataxx_version" do
    assert_difference('AtaxxVersion.count') do
      post :create, ataxx_version: { code: @ataxx_version.code, game_id: @ataxx_version.game_id, name: @ataxx_version.name }
    end

    assert_redirected_to ataxx_version_path(assigns(:ataxx_version))
  end

  test "should show ataxx_version" do
    get :show, id: @ataxx_version
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ataxx_version
    assert_response :success
  end

  test "should update ataxx_version" do
    put :update, id: @ataxx_version, ataxx_version: { code: @ataxx_version.code, game_id: @ataxx_version.game_id, name: @ataxx_version.name }
    assert_redirected_to ataxx_version_path(assigns(:ataxx_version))
  end

  test "should destroy ataxx_version" do
    assert_difference('AtaxxVersion.count', -1) do
      delete :destroy, id: @ataxx_version
    end

    assert_redirected_to ataxx_versions_path
  end
end
