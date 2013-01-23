(function( board, $, undefined ) {
  board.attach = function() {
    var cells = $('td[id^=cell_]');
    cells.each(function(index) {
      // this == the element that fired the change event
      $(this).click(function() {
        // this == the element that fired the change event
        board.click_cell(this.id);
      });
    });
  };

  board.click_cell = function(cell_id) {
    var id_split = cell_id.split('_');
    var cell_x = id_split[1];
    var cell_y = id_split[2];

    // Using the core $.ajax method
    $.ajax({

      // the URL for the request
      url : "http://localhost:3000/update",

      // the data to send
      // (will be converted to a query string)
      data : {
        game_id : game.get_game_id(),
        cell_x : cell_x,
        cell_y : cell_y
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
}( window.board = window.board || {}, jQuery ));


