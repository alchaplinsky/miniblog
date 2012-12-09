class @Social

  constructor: (options, url, container)->
    $(container).append $('<div class="social-likes"></div>')
    $(container).append $('<div class="social-comments"></div>')
    @likes = $(".social-likes")
    @comments = $(".social-comments")
    @url = url
    @options = options
    @initTwitter() if @options.twitter_button
    @initGoogle() if @options.google_button
    @initFacebook() if @options.facebook_button
    @initVk() unless @options.vk_button is false

  initGoogle: ->
    $(@likes).append '<div id="google-widget"><div class="g-plusone" data-size="medium" data-href="'+@url+'"></div></div>'
    $.getScript 'https://apis.google.com/js/plusone.js', ->
      gapi.plusone.go()

  initTwitter: ->
    $(@likes).append '<div id="twitter-widget"><a href="https://twitter.com/share" class="twitter-share-button" data-via="chalexr" data-url="'+@url+'">Tweet</a></div>'
    $.getScript '//platform.twitter.com/widgets.js', ->
      twttr.widgets.load()

  initFacebook: ->
    $("body").prepend('<div id="fb-root"></div><script>(function(d, s, id) {
      var js, fjs = d.getElementsByTagName(s)[0];
      if (d.getElementById(id)) return;
      js = d.createElement(s); js.id = id;
      js.src = "//connect.facebook.net/ru_RU/all.js#xfbml=1";
      fjs.parentNode.insertBefore(js, fjs);
      }(document, "script", "facebook-jssdk"));</script>')
    $(@likes).append '<div id="facebook-widget"><fb:like href="'+@url+'" send="false" layout="button_count" width="450" show_faces="false"></fb:like></div>'
    @facebookComments() if @options.facebook_comments
    FB.XFBML.parse() if FB?

  initVk: ->
    $(@likes).append '<div id="vk-widget"><div id="vk_like"></div></div>'
    $.getScript '//vk.com/js/api/openapi.js?71', =>
      VK.init({apiId: @options.vk_button, onlyWidgets: true})
      VK.Widgets.Like("vk_like", {type: "button", height: 20, pageUrl: @url})
      @vkComments() unless @options.vk_comments is false

  facebookComments: ->
    $(".social-comments").append '<div class="fb-comments" data-href="'+@url+'" data-width="600" data-num-posts="10"></div>'

  vkComments: ->
    VK.Widgets.Comments("vk_comments", {limit: 10, width: "600", attach: false, pageUrl: @url})
    $(".social-comments").append '<div id="vk_comments"></div>'

