(function( board, $, undefined ) {

  var cell_lookup_for_location_id = {};

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
  };

  board.click_cell = function(cell_id) {
    var id_split = cell_id.split('_');
    var location_id = id_split[1];
    // var cell_y = id_split[2];

    // Using the core $.ajax method
    $.ajax({

      // the URL for the request
      url : "/ataxx/update",

      // the data to send
      // (will be converted to a query string)
      data : {
        game_id : game.get_game_id(),
        location_id : location_id
      },

      // whether this is a POST or GET request
      type : "GET",

      // the type of data we expect back
      dataType : "json",

      // code to run if the request succeeds;
      // the response is passed to the function
      success : function( json ) {
        // $("<p/>").text( json.title ).appendTo("body");
        $("#debug_section").text( json.debug );
        refresh_board_from_state(json.state.board);
      },

      // code to run if the request fails;
      // the raw request and status codes are
      // passed to the function
      error : function( xhr, status ) {
        alert(status);
      },

      // code to run regardless of success or failure
      complete : function( xhr, status ) {
        //alert("The request is complete!");
      }

    });
  };

  function refresh_board_from_state(board_state) {
    var player_id;
    var cell;

    $.each(cell_lookup_for_location_id, function(key, value) {
      $(value).removeClass();
    });

    $.each(board_state.pieces, function(index) {
      player_id = this.player_id;
      cell = cell_lookup_for_location_id[this.location_id];
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


      // if (player_id === 1) {
      //   $(cell).addClass('red_piece');
      // } else {
      //   $(cell).addClass('blue_piece');
      // }
    });


  }
}( window.board = window.board || {}, jQuery ));


