(function( game, $, undefined ) {

  var game_id;

  game.attach = function() {
    game_id = $('#game_data').data('game-id');
    board.attach();
    game.update({});
  }

  game.get_game_id = function() {
    return game_id;
  };

  game.update = function(update_data) {
    update_data.game_id = game.get_game_id();
    backend.update(update_data, handle_update);
  };

  function handle_update(state) {
    board.update(state);
  }

}( window.game = window.game || {}, jQuery ));
