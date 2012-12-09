class @SocialLikes

  constructor: (options, url, container)->
    @container = container
    @url = url
    @options = options
    @initFacebook() if @options.facebook_widget
    @initTwitter() if @options.twitter_widget
    @initVk() unless @options.vk_widget is false
    @initGoogle() if @options.google_widget

  initFacebook: ->
    $("body").prepend('<div id="fb-root"></div><script>(function(d, s, id) {
      var js, fjs = d.getElementsByTagName(s)[0];
      if (d.getElementById(id)) return;
      js = d.createElement(s); js.id = id;
      js.src = "//connect.facebook.net/ru_RU/all.js#xfbml=1";
      fjs.parentNode.insertBefore(js, fjs);
      }(document, "script", "facebook-jssdk"));</script>')
    $(@container).append '<div id="facebook-widget"><fb:like href="'+@url+'" send="false" layout="button_count" width="450" show_faces="false"></fb:like></div>'
    FB.XFBML.parse() if FB?

  initTwitter: ->
    $(@container).append '<div id="twitter-widget"><a href="https://twitter.com/share" class="twitter-share-button" data-via="chalexr" data-url="'+@url+'">Tweet</a></div>'
    $.getScript '//platform.twitter.com/widgets.js', ->
      twttr.widgets.load()

  initVk: ->
    $(@container).append '<div id="vk-widget"><div id="vk_like"></div></div>'
    $.getScript '//vk.com/js/api/openapi.js?71', =>
      VK.init({apiId: @options.vk_widget, onlyWidgets: true})
      VK.Widgets.Like("vk_like", {type: "button", height: 20, pageUrl: @url})

  initGoogle: ->
    $(@container).append '<div id="google-widget"><div class="g-plusone" data-size="medium" data-href="'+@url+'"></div></div>'
    $.getScript 'https://apis.google.com/js/plusone.js', ->
      gapi.plusone.go()