//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .
$(document).ready(function(){
  $('[data-js-search]').change(function(event) {
    search_term = $(this).val();
    alert('You are searching for ' + search_term);
  });
});
