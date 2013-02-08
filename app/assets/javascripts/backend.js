(function( backend, $, undefined ) {
  backend.update = function(game_id, data, callback) {
        // Using the core $.ajax method
    $.ajax({

      // the URL for the request
      url : "/ataxx/" + game_id + "/update",

      // the data to send
      // (will be converted to a query string)
      data : data,

      // whether this is a POST or GET request
      type : "GET",

      // the type of data we expect back
      dataType : "json",

      // code to run if the request succeeds;
      // the response is passed to the function
      success : function( json ) {
        // $("<p/>").text( json.title ).appendTo("body");
        $("#debug_section").text( json.debug );
        callback(json.state);
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

}( window.backend = window.backend || {}, jQuery ));

