(function( board, $, undefined ) {

  var cell_lookup_by_location_id = {};
  var piece_lookup_by_location_id = {};
  var piece_lookup_by_id = {};
  var player_lookup_by_number = {};
  var player_lookup_by_id = {};
  var turn_player_id = null;
  var selected_pieces = [];


  board.attach = function() {
    var cells = $('td[id^=cell_]');
    cells.each(function(index) {

      var id_split = this.id.split('_');
      var location_id = id_split[1];
      cell_lookup_by_location_id[location_id] = this;

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
      piece_lookup_by_location_id[location_id] = this;
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
    refresh_players_from_state(state);
    refresh_pieces_from_state(state);
    refresh_board_from_state(state);
    refresh_status_sections();
    refresh_message_from_state(state);
  };

  function refresh_players_from_state(state) {
    var players = state.players;

    turn_player_id = state.turn_player_id;

    player_lookup_by_id = {}
    player_lookup_by_number = {}
    pieces_lookup_by_player_id = {}
    $.each(players, function(index) {
      player_lookup_by_id[this.id] = this
      player_lookup_by_number[this.number] = this
      pieces_lookup_by_player_id[this.id] = []
    });
  }

  function refresh_pieces_from_state(state) {
    var pieces = state.pieces;

    piece_lookup_by_id = {}
    $.each(pieces.all, function(index, piece) {
      piece_lookup_by_id[piece.id] = piece
      pieces_lookup_by_player_id[piece.player_id].push(piece.id)
    });
    selected_pieces = state.pieces.selected
  }

  function refresh_board_from_state(state) {
    var player_id;
    var cell;

    $.each(piece_lookup_by_location_id, function(key, value) {
      $(value).removeClass();
    });

    $.each(piece_lookup_by_id, function(piece_id, piece) {
      var player = player_lookup_by_id[piece.player_id];
      var piece_element = piece_lookup_by_location_id[piece.location.id];
      switch (player.number) {
        case 1:
          $(piece_element).addClass('red_piece');
          break;
        case 2:
          $(piece_element).addClass('blue_piece');
          break;
        default:
          $(piece_element).removeClass();
          break;
      }
    });

    $.each(cell_lookup_by_location_id, function(location_id, cell) {
      $(cell).removeClass('cell_active');
    });

    $.each(selected_pieces, function(index, piece_id) {
      piece = piece_lookup_by_id[piece_id];
      var piece_element = piece_lookup_by_location_id[piece.location.id];
      $(piece_element).addClass('gps_ring');

      $.each(piece.moves, function(move) {
        var cell = cell_lookup_by_location_id[move];
        $(cell).addClass('cell_active');
      });
    });

    // $.each(cell_lookup_by_location_id, function(key, value) {
    //   // cell = cell_lookup_by_location_id[this];
    //   if ($.inArray(key, board_state.available_moves) > -1) {
    //     $(value).addClass('cell_active');
    //   } else {
    //     $(value).removeClass('cell_active');
    //   }
    // });

    // $.each(board_state.available_moves, function(index, value) {
    //   cell = cell_lookup_by_location_id[value];
    //   $(cell).addClass('cell_active');
    // });



  }

  function refresh_status_sections() {

    $('#stats_left').find('#piece_count').text(pieces_lookup_by_player_id[player_lookup_by_number[1].id].length);
    $('#stats_right').find('#piece_count').text(pieces_lookup_by_player_id[player_lookup_by_number[2].id].length);

    switch (player_lookup_by_id[turn_player_id].number) {
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


