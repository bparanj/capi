rails new capi --api

rails g scaffold article title content:text

gem 'mysql2'

bundle

$rails db:create
Specified 'mysql2' for database adapter, but the gem is not loaded. Add `gem 'mysql2'` to your Gemfile (and ensure its version is at the minimum required by ActiveRecord).
Couldn't create database for {"adapter"=>"mysql2", "encoding"=>"utf8", "reconnect"=>false, "database"=>"capi_development", "pool"=>5, "username"=>"root", "password"=>nil}
rails aborted!


rails db:create
rails db:migrate


To export only articles table, from the root of your Rails project:

mysqldump -p ––user=username dbname articles > articles.sql

Importing the articles table:

mysql -u username -p -D dbname < articles.sql

rails s 

http://localhost:3000/articles

You can install JSON Viewer Chrome extension to view the formatted JSON.


Create index.html:

<!DOCTYPE html>
<html>
  <head>
    <title>Hello jQuery JSON</title>
    <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
  </head>

  <body>

  </body>
  
  <script>
    $.getJSON( "http://localhost:3030/articles", function(json) {
      console.log( "JSON Data: " + json);
     });
  </script>
</html>


Open this on a browser, inspect to view the console, you will see an error message:

XMLHttpRequest cannot load http://localhost:3030/articles. No 'Access-Control-Allow-Origin' header is present on the requested resource. Origin 'null' is therefore not allowed access.

Uncomment: gem 'rack-cors' in Gemfile

Run bundle. Open config/initializers/cors.rb:


Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end

Does not work.

Change: origins '*'

$rails middleware
use Rack::Cors
use Rack::Sendfile
use ActionDispatch::Static
use ActionDispatch::Executor
use ActiveSupport::Cache::Strategy::LocalCache::Middleware
use Rack::Runtime
use ActionDispatch::RequestId
use ActionDispatch::RemoteIp
use Rails::Rack::Logger
use ActionDispatch::ShowExceptions
use ActionDispatch::DebugExceptions
use ActionDispatch::Reloader
use ActionDispatch::Callbacks
use ActiveRecord::Migration::CheckPending
use Rack::Head
use Rack::ConditionalGet
use Rack::ETag
run Capi::Application.routes

It will now work.

JSON.stringify(object)


How do I iterate through this JSON object in jQuery?


  <script>
    $.getJSON( "http://localhost:3030/articles", function(data) {
      var articles = JSON.stringify(data);
      $.each(articles, function(k, v){
        console.log("Key: " + k + ", Value: " + v);
      });
      console.log("Article 1: " + articles)
     });
  </script>

Uncaught TypeError: Cannot use 'in' operator to search for



  <script>
    $.getJSON( "http://localhost:3030/articles", function(data) {
      var articles = $.parseJSON(data);
      $.each(articles, function(k, v){
        console.log("Key: " + k + ", Value: " + v);
      });
      console.log("Article 1: " + articles)
     });
  </script>
</html>




Uncaught SyntaxError: Unexpected token o in JSON at position 1



<script>
  $.getJSON("http://localhost:3030/articles", function(data) {
    console.log("Article 1: " + data);
    console.log("Article 1: " + data.size);
   });
</script>

data.size is not available, you can see in the console, length is available.

You can set a breakpoint inside the getJSON call and see in the console that the objects are in an array. The array size is 10.

Image goes here.

Iterating over an array:

$.each( [ "a", "b", "c" ], function( i, l ){
  alert( "Index #" + i + ": " + l );
});

Looping through an array:

  <script>
    $.getJSON( "http://localhost:3030/articles", function(data) {
      $.each(data, function(i, a){
        console.log("Index: " + i + ", Value: " + a);
      });
      console.log("Article 1: " + data)
     });
  </script>
     
Listing all key-values for the article hash:

    $.getJSON( "http://localhost:3030/articles", function(data) {
      $.each(data, function(i, article){
        console.log("Index: " + i + ", Value: " + article);
        $.each(article, function(k, v) {
          console.log( "Key: " + k + ", Value: " + v);
        });
      });
      console.log("Article 1: " + data)
     });
     
     
     Listing article id and title for all the articles:
     
     <script>
       $.getJSON( "http://localhost:3030/articles", function(data) {
         $.each(data, function(i, article){
           console.log(article['id']);
           console.log(article['title']);
         });
        });
     </script>
        
~/projects/capi $mysqldump -uroot lafon_development articles > articles.sql

mysql -u root -p -D capi_development < articles.sql



Uncaught TypeError: Cannot use 'in' operator to search for jquery
We have a JSON string, not an object. 

References

[Rails 5 API and CORS](https://til.hashrocket.com/posts/4d7f12b213-rails-5-api-and-cors)
[Rack CORS](https://github.com/cyu/rack-cors)
[jQuery each](http://api.jquery.com/jquery.each/)
[Generating seeds.rb From Existing Data](http://www.xyzpub.com/en/ruby-on-rails/3.2/seed_rb.html)



<div id="app">
  <div class="container">
    <h1>Articles</h1> 
  
    <ul v-if="articles && articles.length">
      <li v-for="article of articles">
        <p><strong>{{article.id}}</strong></p>
        <p>{{article.title}}</p>
      </li>
    </ul>

    <ul v-if="errors && errors.length">
      <li v-for="error of errors">
        {{error.message}}
      </li>
    </ul>
    
  </div>
</div>















<div id="app">
  <div class="container">
    <h1>Articles</h1> 
      <ul class="list-group">
        <story v-for="article in articles">
        </story> 
      </ul>
    <pre>{{ $data }}</pre> </div>
  </div>
</div>


<template>
  <ul v-if="articles && articles.length">
    <li v-for="article of articles">
      <p><strong>{{article.id}}</strong></p>
      <p>{{article.title}}</p>
    </li>
  </ul>

  <ul v-if="errors && errors.length">
    <li v-for="error of errors">
      {{error.message}}
    </li>
  </ul>
</template>











Notes

SELECT A,B,C
INTO OUTFILE '/tmp/article.txt'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM X;


LOAD DATA INFILE '/tmp/article.txt'
INTO TABLE X
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';



https://demisx.github.io/rails-api/2014/02/18/configure-accept-headers-cors.html NOT WORKING

In application.rb:

config.action_dispatch.default_headers = {
    'Access-Control-Allow-Origin' => '*',
    'Access-Control-Request-Method' => 'GET'
}

Enable CORS. Restart the server.

$.getJSON( "ajax/test.json", function( data ) {
  var items = [];
  $.each( data, function( key, val ) {
    items.push( "<li id='" + key + "'>" + val + "</li>" );
  });
 
  $( "<ul/>", {
    "class": "my-new-list",
    html: items.join( "" )
  }).appendTo( "body" );
});



Uncaught SyntaxError: Unexpected token o in JSON at position 1