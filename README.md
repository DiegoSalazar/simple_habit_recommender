# Simple Habit Recommender

This project is my solution to the Simple Habit interview challenge to build a simple topic recommender based on data they sent me.

## Usage

Go to `http://simplehabitrecommender.herokuapp.com/recommendations?subtopic=XYZ` where the `subtopic` is the ID of one of the topics in `lib/subtopics.json`. You will receive either an HTML page or JSON response depending on how the request is fired.

To receive JSON run: 

```bash
curl -H"ACCEPT: application/json" http://simplehabitrecommender.herokuapp.com?recommendations?subtopic=XYZ
```

## Getting Started

1. Install Rails at the command prompt if you haven't yet:

        $ gem install rails

2. At the command prompt, create a new Rails application:

        $ rails new myapp

   where "myapp" is the application name.

3. Change directory to `myapp` and start the web server:

        $ cd myapp
        $ rails server

   Run with `--help` or `-h` for options.

4. Using a browser, go to `http://localhost:3000` and you'll see:
"Yay! You’re on Rails!"

5. Follow the guidelines to start developing your application. You may find
   the following resources handy:
    * [Getting Started with Rails](http://guides.rubyonrails.org/getting_started.html)
    * [Ruby on Rails Guides](http://guides.rubyonrails.org)
    * [The API Documentation](http://api.rubyonrails.org)
    * [Ruby on Rails Tutorial](http://www.railstutorial.org/book)

## License

Ruby on Rails is released under the [MIT License](http://www.opensource.org/licenses/MIT).
