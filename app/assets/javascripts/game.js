(function( game, $, undefined ) {

  var game_id;

  game.attach = function() {
    game_id = $('#game_data').data('game-id');
  }

  game.get_game_id = function() {
    return game_id;
  };

}( window.game = window.game || {}, jQuery ));
