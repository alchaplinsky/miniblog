class @Blog

  constructor: (options) ->
    @options = $.extend(
      root: "#entry_body"
      navigation: "#navigation"
      post_folder: "posts"
      posts: []
      contents: {}
      likes:
        google_widget: false
        facebook_widget: false
        vk_widget: false
        tweeter_widget: false
    , options)

    @posts = @options.posts
    @loadContent(@initialUrl(@posts))
    $("a").click (e) =>
      e.preventDefault()
      return false if $(e.target).hasClass("disabled")
      @loadContent($(e.target).attr("href"))
      document.location.hash = "##{$(e.target).attr("href")}"

  initialUrl: (posts)->
    hash = document.location.hash.substr(1)
    if (hash == "" || posts.indexOf(hash.split(".")[0]) == -1)
      url = @posts[0]+".html"
      document.location.hash = url
    else
      url = hash
    url

  loadContent: (url) ->
    $.ajax
      url: "/#{@options.post_folder}/#{url}"
      type: "GET"
      success: (data) =>
        @yeildContent(data)
        @setLinks()
      error: ->
        console.log "Error occured while loading post content"

  yeildContent: (html) ->
    $(@options.root).html(html)
    $("title").html($("#{@options.root} h1").text())
    @addSocialButtons()

  url: ->
    "#{document.location.protocol}//#{document.domain}/#{document.location.hash}"

  addSocialButtons: ->
    $(@options.root).append($('<div class="social-likes"></div'))
    new SocialLikes(@options.likes, @url(), $(".social-likes"))

  currentPost: ->
    document.location.hash.split(".")[0].substr(1)

  getPost: (direction) ->
    index = @posts.indexOf(@currentPost())
    unless index is -1
      index = if (direction is "next") then index+1 else index-1
      return @posts[index] unless @posts[index] is undefined
    return false

  setLinks: ->
    back = $(@options.navigation).find(".back")
    fwd = $(@options.navigation).find(".forward")
    if prev = @getPost("previous")
      $(back).attr("href", prev+".html").removeClass("disabled")
    else
      $(back).attr("href", "#").addClass("disabled")
    if next = @getPost("next")
      $(fwd).attr("href", next+".html").removeClass("disabled")
    else
      $(fwd).attr("href", "#").addClass("disabled")
