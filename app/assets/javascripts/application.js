// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .
//= require moment
//= require bootstrap-datetimepicker


$(document).on('ready page:load', function() {
    return $('.datepicker').datetimepicker({
    format: 'YYYY-MM-DD HH:00'
  });
});

$(document).on('ready page:load', function() {
    return $('.birthday').datetimepicker({
    format: 'YYYY-MM-DD'
  });
});

$(function() {

  //利用規約への同意エラー表示スタイル調整
  error_block = $(".agreement  .help-inline");
  if(error_block){
      $(".agreement").prepend(error_block);
  	error_block.css({"color":"#CD5C5C", "font-size":"small"});
  }
 });

 $(function() {

   //利用規約への同意エラー表示スタイル調整
   error_block = $(".agreement  .help-inline");
   if(error_block){
       $(".agreement").prepend(error_block);
   	error_block.css({"color":"#CD5C5C", "font-size":"small"});
   }
  });
