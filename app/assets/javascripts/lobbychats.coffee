# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

App.makelobbychat = App.cable.subscriptions.create "MakelobbychatChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    unless data.body.blank?
      $('#lobbylist').append '<div class="chat" style="color:#' + data.color + '"><strong>' + data.username + ':</strong> ' + data.body + '</div>'
    scroll_bottom()
    clear()

scroll_bottom = () ->
  $('#lobbylist').scrollTop($('#lobbylist')[0].scrollHeight)

clear = ->
  document.getElementById('lobbychat_body').value = ''
  return
