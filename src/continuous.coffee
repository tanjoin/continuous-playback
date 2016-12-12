class Continuous
  constructor: (@videoPlayer, @videos = [], @autoRepeat = false, @callback) ->
    @init_ videos, @callback

  init_: (videos, callback) ->
    @videoPlayer.setAttribute "src", videos[0]
    @videoPlayer.setAttribute "video_index", 0
    @videoPlayer.onended = (e) =>
      index = parseInt @videoPlayer.getAttribute "video_index"
      index = index + 1
      if index < videos.length
        @play_ index
      else if index is videos.length and @autoRepeat
        @play_ 0
    return @

  play_: (index) ->
    @videoPlayer.setAttribute "video_index", index
    @videoPlayer.setAttribute "src", @videos[index]
    @videoPlayer.play()
    if @callback
      @callback index, videos[index]
    return @

  play: (index) ->
    @play_ index

  playAfterReset: ->
    @play_ 0
