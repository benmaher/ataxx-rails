require 'test_helper'

class AtaxxBoardsControllerTest < ActionController::TestCase
  setup do
    @ataxx_board = ataxx_boards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ataxx_boards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ataxx_board" do
    assert_difference('AtaxxBoard.count') do
      post :create, ataxx_board: { name: @ataxx_board.name, x_size: @ataxx_board.x_size, y_size: @ataxx_board.y_size }
    end

    assert_redirected_to ataxx_board_path(assigns(:ataxx_board))
  end

  test "should show ataxx_board" do
    get :show, id: @ataxx_board
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ataxx_board
    assert_response :success
  end

  test "should update ataxx_board" do
    put :update, id: @ataxx_board, ataxx_board: { name: @ataxx_board.name, x_size: @ataxx_board.x_size, y_size: @ataxx_board.y_size }
    assert_redirected_to ataxx_board_path(assigns(:ataxx_board))
  end

  test "should destroy ataxx_board" do
    assert_difference('AtaxxBoard.count', -1) do
      delete :destroy, id: @ataxx_board
    end

    assert_redirected_to ataxx_boards_path
  end
end
