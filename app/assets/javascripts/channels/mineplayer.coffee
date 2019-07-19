App.mineplayer = App.cable.subscriptions.create "MineplayerChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
     unless data.playerid.blank?
      if $('#player' + data.playerid )?
        $('#player' + data.playerid ).css('bottom', data.deltay + 'px')
        $('#player' + data.playerid ).css('left', data.deltax + 'px')
      # else
      #   $('#minemap ).append  '<div class="player" id="player' + data.playerid + '">New Player<br><span style="color:#000000"><i class="fas fa-walking mineicon"></i></span></div>'
      #   $('#player' + data.playerid ).css('bottom', data.deltay + 'px')
      #   $('#player' + data.playerid ).css('left', data.deltax + 'px')
