require 'test_helper'

class AtaxxSessionsControllerTest < ActionController::TestCase
  setup do
    @ataxx_session = ataxx_sessions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ataxx_sessions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ataxx_session" do
    assert_difference('AtaxxSession.count') do
      post :create, ataxx_session: { ataxx_board_id: @ataxx_session.ataxx_board_id, ataxx_version_id: @ataxx_session.ataxx_version_id, state: @ataxx_session.state }
    end

    assert_redirected_to ataxx_session_path(assigns(:ataxx_session))
  end

  test "should show ataxx_session" do
    get :show, id: @ataxx_session
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ataxx_session
    assert_response :success
  end

  test "should update ataxx_session" do
    put :update, id: @ataxx_session, ataxx_session: { ataxx_board_id: @ataxx_session.ataxx_board_id, ataxx_version_id: @ataxx_session.ataxx_version_id, state: @ataxx_session.state }
    assert_redirected_to ataxx_session_path(assigns(:ataxx_session))
  end

  test "should destroy ataxx_session" do
    assert_difference('AtaxxSession.count', -1) do
      delete :destroy, id: @ataxx_session
    end

    assert_redirected_to ataxx_sessions_path
  end
end
