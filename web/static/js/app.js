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

$(".addedLink").click(function(event) {
  event.preventDefault();
  var $element = $(event.target);

  UJS.xhr("/api/groups", "POST", {
    type: "json",
    data: { gid: $element.data("id") },
    success: function(xhr) {
      $element.addClass("hidden");
      $element.parent().find(".removedLink").removeClass("hidden");
    }
  });
});

$(".removedLink").click(function(event) {
  event.preventDefault();
  var $element = $(event.target);
  var path = "/api/groups/" + $element.data("id");

  UJS.xhr(path, "DELETE", {
    type: "json",
    success: function(xhr) {
      $element.addClass("hidden");
      $element.parent().find(".addedLink").removeClass("hidden");
    }
  });
});

var xmlns = "http://www.w3.org/2000/svg",
  xlinkns = "http://www.w3.org/1999/xlink",
  select = function(s) {
    return document.querySelector(s);
  },
  selectAll = function(s) {
    return document.querySelectorAll(s);
  },
    lineSelector = select('#lineSelector'),
    hitArea = select('#hitArea'),
    hitL = select('#hitL'),
    hitR = select('#hitR'),
    base = select('#base'),
    selectorColorArray = ['#4CAF50', '#F44336']


TweenMax.set('svg', {
  visibility: 'visible'
})

var introTl = new TimelineMax({paused:false, onComplete:createInteraction});
introTl.from(base, 0.4, {
  strokeWidth:0,
  delay:1
})
.from(lineSelector, 0.2, {
 strokeWidth:0
},'-=0.2')
.from(base, 0.4, {
  attr:{
    x1:400,
    x2:400
  },
  ease:Anticipate.easeIn

})
.from(lineSelector, 0.4, {
  attr:{
    x1:400,
    x2:400
  },
  ease:Anticipate.easeIn
},'-=0.4')

var tl = new TimelineMax({paused:true});
function createInteraction(){
  tl.to(lineSelector, 0.5, {
    attr:{
      x2:450
    },
    strokeWidth:30,
    ease:Power1.easeIn
  })
  .from(hitL, 1, {
    attr:{
      r:30
    },
    alpha:1,
    immediateRender:false,
    ease:Power1.easeOut
  },'-=0.5')
  .to(lineSelector, 1, {
    attr:{
      x1:450
    },
    strokeWidth:60,
    stroke:selectorColorArray[0],
    ease:Elastic.easeOut.config(1, 0.59)
  },'-=0.5')
  .to(base, 0.15,{
    attr:{
      x2:460
    },
    repeat:1,
    yoyo:true
  },'-=0.85')
  .to(base, 0.15,{
    attr:{
      x1:348
    },
    repeat:1,
    yoyo:true
  },'-=0.6')

  .addPause()
  .to(lineSelector, 0.5, {
    attr:{
      x1:350
    },
    strokeWidth:30,
    ease:Power1.easeIn
  })
  .from(hitR, 1, {
    attr:{
      r:30
    },
    alpha:1,
    immediateRender:false,
    ease:Power1.easeOut
  },'-=0.5')
  .to(lineSelector, 1, {
    attr:{
      x2:350
    },
    strokeWidth:60,
    stroke:selectorColorArray[1],
    ease:Elastic.easeOut.config(1, 0.59)
  },'-=0.5')
  .to(base, 0.15,{
    attr:{
      x1:340
    },
    repeat:1,
    yoyo:true
  },'-=0.85')
  .to(base, 0.15,{
    attr:{
      x2:452
    },
    repeat:1,
    yoyo:true
  },'-=0.6')

  hitArea.onclick = function(){

    if(tl.time() == tl.duration()){
      tl.play(0)
    } else {
      tl.play()
    }
  }

  hitArea.ontouchstart = hitArea.onclick;

  tl.timeScale(1.8);
  tl.progress(1);
}
