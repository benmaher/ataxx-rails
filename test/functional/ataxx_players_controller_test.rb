require 'test_helper'

class AtaxxPlayersControllerTest < ActionController::TestCase
  setup do
    @ataxx_player = ataxx_players(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ataxx_players)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ataxx_player" do
    assert_difference('AtaxxPlayer.count') do
      post :create, ataxx_player: { ataxx_session_id: @ataxx_player.ataxx_session_id, number: @ataxx_player.number, user_id: @ataxx_player.user_id }
    end

    assert_redirected_to ataxx_player_path(assigns(:ataxx_player))
  end

  test "should show ataxx_player" do
    get :show, id: @ataxx_player
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ataxx_player
    assert_response :success
  end

  test "should update ataxx_player" do
    put :update, id: @ataxx_player, ataxx_player: { ataxx_session_id: @ataxx_player.ataxx_session_id, number: @ataxx_player.number, user_id: @ataxx_player.user_id }
    assert_redirected_to ataxx_player_path(assigns(:ataxx_player))
  end

  test "should destroy ataxx_player" do
    assert_difference('AtaxxPlayer.count', -1) do
      delete :destroy, id: @ataxx_player
    end

    assert_redirected_to ataxx_players_path
  end
end
