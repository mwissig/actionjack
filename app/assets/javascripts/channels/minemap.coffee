App.minemap = App.cable.subscriptions.create "MinemapChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    unless data.coords.blank?
     $('#' + data.coords + '_foreground' ).removeClass data.changefrom
     $('#' + data.coords + '_foreground' ).addClass data.changeto
