# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
App.tictactoe = App.cable.subscriptions.create "TictactoeChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if data.a1 != undefined
      document.getElementById('a1_' + data.id ).innerHTML = data.a1
    if data.a2 != undefined
      document.getElementById('a2_' + data.id ).innerHTML = data.a2
    if data.a3 != undefined
      document.getElementById('a3_' + data.id ).innerHTML = data.a3
    if data.b1 != undefined
      document.getElementById('b1_' + data.id ).innerHTML = data.b1
    if data.b2 != undefined
      document.getElementById('b2_' + data.id ).innerHTML = data.b2
    if data.b3 != undefined
      document.getElementById('b3_' + data.id ).innerHTML = data.b3
    if data.c1 != undefined
      document.getElementById('c1_' + data.id ).innerHTML = data.c1
    if data.c2 != undefined
      document.getElementById('c2_' + data.id ).innerHTML = data.c2
    if data.c3 != undefined
      document.getElementById('c3_' + data.id ).innerHTML = data.c3
