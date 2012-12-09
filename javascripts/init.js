$(document).ready(function(){
  var posts = Array(   // Blogposts list in array
    "sample_post",
    "more"             // Should describe html files names in posts folder
  );

  var options = {
    social: {
      google_button: true,     // Google plus button initialization - true | false
      facebook_button: true,   // Facebool like button initialization - true | false
      vk_button: 3286787,        // Vk Share button initialization - APP_ID | false
      twitter_button: true,    // Tweet button initialization - true | false
      vk_comments: 3286787,
      facebook_comments: false
    },
    posts: posts              // Array of posts
  }

  Feed = new Blog(options);
});
