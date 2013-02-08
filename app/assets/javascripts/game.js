(function( game, $, undefined ) {

  var game_id;

  game.attach = function() {
    game_id = $('#game_data').data('game-id');
    board.attach();

    if (game_id !== null) {
      game.update({});
    }
  }

  game.get_game_id = function() {
    return game_id;
  };

  game.update = function(update_data) {
    backend.update(game_id, update_data, handle_update);
  };

  function handle_update(state) {
    board.update(state);
  }

}( window.game = window.game || {}, jQuery ));
