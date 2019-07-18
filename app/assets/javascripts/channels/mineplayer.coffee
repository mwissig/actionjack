App.mineplayer = App.cable.subscriptions.create "MineplayerChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
     unless data.deltax.blank?
      $('#player' + data.id ).style.bottom = data.deltay + "px";
      $('#player' + data.id ).style.left = data.deltax + "px";
