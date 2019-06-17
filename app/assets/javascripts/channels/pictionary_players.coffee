App.pictionary_players = App.cable.subscriptions.create "PictionaryPlayersChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    unless data.name.blank?
      $('#onlineusers').append '<p>' + data.name + ' logged on ' + data.last_online + '</p>'
