// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"
import UJS from "phoenix_ujs";
import $ from "jquery";

$(".switcher").on("change", function(event) {
  event.preventDefault();

  var $element = $(".switcher");
  if($element.prop("checked")) {
    UJS.xhr("/api/groups", "POST", {
      type: "json",
      data: { gid: $element.data("id") },
    });
  } else {
    UJS.xhr("/api/groups/" + $element.data("id"), "DELETE", {
      type: "json"
    });
  }
});
