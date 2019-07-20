// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require_tree .
//= require jstz
//= require jquery3
//= require jquery_ujs

console.log('js working');

window.addEventListener('load', function() {
  var box = document.getElementById('lobbylist')
  box.scrollTop = box.scrollHeight;
});

$(document).ready(function(){
  document.getElementById('user_time_zone').value = jstz.determine().name();
})

var chatFocus = true;

function focusLobby() {
  focusmodal.classList.remove("hidden");
  chatFocus = true;
}
