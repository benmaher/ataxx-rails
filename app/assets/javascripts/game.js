(function( game, $, undefined ) {

  //game_id = ':' + '<%= @game_id %>' + ':';

  // var game_id = ':' + "<%= @game_id.to_json %>" + ':';

  var game_id;
  game.attach = function() {
    game_id = $('#game_data').data('game-id');
  }

  game.get_game_id = function() {
    return game_id;
  };

}( window.game = window.game || {}, jQuery ));
