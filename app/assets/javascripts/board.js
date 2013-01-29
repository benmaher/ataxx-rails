(function( board, $, undefined ) {

  var cell_lookup_for_location_id = {};
  var piece_lookup_for_location_id = {};

  board.attach = function() {
    var cells = $('td[id^=cell_]');
    cells.each(function(index) {

      var id_split = this.id.split('_');
      var location_id = id_split[1];
      cell_lookup_for_location_id[location_id] = this;

      // this == the element that fired the change event
      $(this).click(function() {
        // this == the element that fired the change event
        board.click_cell(this.id);
      });
    });

    var pieces = $('[id^=piece_]');
    pieces.each(function(index) {

      var id_split = this.id.split('_');
      var location_id = id_split[1];
      piece_lookup_for_location_id[location_id] = this;
    });
  };

  board.click_cell = function(cell_id) {
    var id_split = cell_id.split('_');
    var location_id = id_split[1];
    // var cell_y = id_split[2];

    game.update({
        location_id : location_id
      });
  };

  board.update = function(state) {
    refresh_board_from_state(state.board);
    refresh_players_from_state(state);
    refresh_message_from_state(state);
  };

  function refresh_board_from_state(board_state) {
    var player_id;
    var cell;

    $.each(piece_lookup_for_location_id, function(key, value) {
      $(value).removeClass();
    });

    $.each(board_state.pieces, function(index) {
      player_id = this.player_id;
      cell = piece_lookup_for_location_id[this.location_id];
      switch (player_id) {
        case 1:
          $(cell).addClass('red_piece');
          break;
        case 2:
          $(cell).addClass('blue_piece');
          break;
        default:
          $(cell).removeClass();
          break;
      }
    });

    $.each(board_state.selected_pieces, function(index) {
      player_id = this.player_id;
      cell = piece_lookup_for_location_id[this.location_id];
      $(cell).addClass('gps_ring');
    });

    $.each(cell_lookup_for_location_id, function(key, value) {
      // cell = cell_lookup_for_location_id[this];
      if ($.inArray(key, board_state.available_moves) > -1) {
        $(value).addClass('cell_active');
      } else {
        $(value).removeClass('cell_active');
      }
    });

    // $.each(board_state.available_moves, function(index, value) {
    //   cell = cell_lookup_for_location_id[value];
    //   $(cell).addClass('cell_active');
    // });



  }

  function refresh_players_from_state(state) {
    var players = state.players;
    $('#stats_left').find('#piece_count').text(players[1].piece_count);
    $('#stats_right').find('#piece_count').text(players[2].piece_count);

    switch (state.active_player_id) {
      case 1:
        $('#stats_left').addClass('stats_active');
        $('#stats_right').removeClass('stats_active');
        break;
      case 2:
        $('#stats_left').removeClass('stats_active');
        $('#stats_right').addClass('stats_active');
        break;
      default:
        $('#stats_left').removeClass('stats_active');
        $('#stats_right').removeClass('stats_active');
        break;
    }


  }

  function refresh_message_from_state(state) {
    var message = state.message;
    if (message != null) {
      $('#message_section').html(message);
    } else {
      $('#message_section').text("");
    }
  }


}( window.board = window.board || {}, jQuery ));


