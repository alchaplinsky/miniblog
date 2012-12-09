$(document).ready(function(){
  var thred1 = Array(   // Blogposts list in array
    "sample_post"             // Should describe html files names in posts folder
  );

  var options = {
    likes: {
      google_widget: true,     // Google plus button initialization - true | false
      facebook_widget: true,   // Facebool like button initialization - true | false
      vk_widget: false,        // Vk Share button initialization - APP_ID | false
      twitter_widget: true,    // Tweet button initialization - true | false
    },
    posts: thred1              // Array of posts
  }

  Feed = new Blog(options);
});
