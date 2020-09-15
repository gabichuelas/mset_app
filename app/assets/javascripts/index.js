//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .


$( document ).ready(function() {
  $("#hide").click(function(){
    $("p").hide();
   });
});

$( document ).ready(function() {
  $("#show").click(function(){
    $("p").show();
  });
});
