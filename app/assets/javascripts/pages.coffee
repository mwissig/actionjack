# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
App.pages = App.cable.subscriptions.create "pictionary_channel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    unless data.fromx.blank?
      drawLine(data.fromx, data.fromy, data.tox, data.toy, data.color, data.size)
