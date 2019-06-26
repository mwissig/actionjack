# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

App.makegamechat = App.cable.subscriptions.create "MakegamechatChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    unless data.body.blank?
      $('#gamechatlist_' + data.game + '_' + data.id ).append  '<div class="chat" style="color:#' + data.color + '"><strong><a style="color:#' + data.color + '" href="' + data.userpath + '">' + data.username + '</a>:</strong> ' + data.body + '</div>'
      $('#gamechatlist_' + data.game + '_' + data.id ).scrollTop($('#gamechatlist_' + data.game + '_' + data.id)[0].scrollHeight)
      cleargc()

cleargc = ->
  document.getElementById('gamechat_body').value = ''
  return
