(function( object_utils, $, undefined ) {

  object_utils.is_undefined_or_null = function(obj) {
    return typeof obj === 'undefined' || obj === null
  }


}( window.object_utils = window.object_utils || {}, jQuery ));
