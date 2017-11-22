App.comments = App.cable.subscriptions.create "CommentsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $("#messages .comment-fix:first").prepend(data)#'.comment-fix:first' combined with 'comment-fix' in _comment, puts new comments within the pagination buttons.
    # Called when there's incoming data on the websocket for this channel
