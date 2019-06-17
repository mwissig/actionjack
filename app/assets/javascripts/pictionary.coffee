App.pictionary = App.cable.subscriptions.create "PictionaryChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    unless data.fromx.blank?
      drawLine(data.fromx, data.fromy, data.tox, data.toy, data.color)
