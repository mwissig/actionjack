# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

console.log('checkers');

checkersHighlight = (id) ->
  console.log id
  document.getElementById(id).classList.toggle 'ck_highlight'
  console.log 'done'
  return

document.getElementById("black_01").addEventListener("click", ckHighlickt(id));
