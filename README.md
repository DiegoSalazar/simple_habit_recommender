# Simple Habit Recommender

This project is my solution to the Simple Habit challenge to build a simple topic recommender based on data they sent me.

## Demo

[simplehabitrecommender.herokuapp.com](http://simplehabitrecommender.herokuapp.com)

## Usage

Go to `http://simplehabitrecommender.herokuapp.com/recommendations?subtopic=X` where **X** is the ID of one of the topics in [lib/data/subtopics.json](https://github.com/DiegoSalazar/simple_habit_recommender/blob/master/lib/data/subtopics.json). You will receive either an HTML page or JSON response depending on how the request is fired.

To receive JSON do either: 

**Browser**

Add `.json` to the end of the `/recommendations` part of the URL:

e.g. http://simplehabitrecommender.herokuapp.com/recommendations.json?subtopic=X

Or run this command in the:

**Terminal**

```bash
curl -H"ACCEPT: application/json" http://simplehabitrecommender.herokuapp.com/recommendations?subtopic=X
```

## How I solved the challenge

I created a Rails App to utilize its db tools to load the data from the two json files in `lib/data`. I designed the relational data schema to define the relationship between the Sub Topics, Listens, and Users. I then wrote a SQL query and some Ruby post processing code to display the top four recommendations for sub topics that users who also listened to the queried sub topic have also listened to.

I then added HTML and styling to display the data and query interface in [a neat little app on Heroku](http://simplehabitrecommender.herokuapp.com).

The core algorithm that gathers recommendations from a given subtopic is:

```sql
SELECT subtopic_id, COUNT(id) AS listens_count FROM listens
WHERE listens.user_id IN (
  SELECT users.user_id FROM users
  RIGHT JOIN listens ON listens.user_id = users.user_id
  WHERE listens.subtopic_id = '#{@subtopic_id}'
) 
AND listens.subtopic_id != '#{@subtopic_id}'
GROUP BY subtopic_id
ORDER BY listens_count DESC
```

## Challenge Instructions

For this exercise, we want to be able to build a simple recommendation engine for Simple Habit meditators. To do this, we’ve included a list of all the meditations that have been completed by users on our site — this file is called ‘listens.json’. The format of this file is a JSON array that contains objects that contain three properties:

    subtopic: a UUID of the subtopic that was listened to
    listenDate: an ISO date string of when the listen occurred
    user: a UUID of the user who listened to the meditation

For reference, there is also a table of subtopics that can translate the subtopic UUIDs into real names and descriptions. The format of this document is a JSON array that contains objects that match:

    id: The UUID of the subtopic
    name: The name of the subtopic
    description: A description of the subtopic

Subtopics correspond to the multi-day series on our platform.

We want to build a very simple recommendation engine here. After a user finishes a meditation, we want to recommend them other series to listen to. The most basic algorithm here is conditional probability. Basically, for every subtopic S, we want to determine the most popular subtopics that users who listened to S also listened to. So for example, if the listens look like:

    User A: listened to 1, 4, 5
    User B: listened to 1, 3, 5
    User C: listened to 2, 3, 5

A recommendation for meditation 1 would be meditation 5, since of the two users who listened to meditation 1, 100% of them also listened to meditation 5. Similarly, the recommendations for meditation 5 would be meditations 1 or 3, based on co-occurrences. (There are definitely better recommendation engines than this, but this is the simplest to explain.)

The deliverable here will be a server that will service one route: /recommendations?subtopic=X that will return a list of subtopics to recommend, given that a user just listened to X.

- Feel free to use any language you feel comfortable using.
- Feel free also to use any third party libraries or external services you feel comfortable using, for example using a MySQL or Mongo engine is fine.
- The return format of the API should be a JSON list of the top 4 subtopic UUIDs that the engine would recommend. If there are not enough recommendations, then showing fewer is fine.
- The startup time of the server can take as long as you need.
- No need to support live updates to the recommendation engine — assume this data is all that is needed.
- In terms of performance, we want the service times of the API call to be as fast as possible.
- When you have a server implementation, create a .zip file of it and whatever other scripts you produced and send it back via email.

## Getting Started

1. Install Rails at the command prompt if you haven't yet:

        $ gem install rails

2. At the command prompt, create a new Rails application:

        $ rails new myapp

   where "myapp" is the application name.

3. Change directory to `myapp`, load the data, and start the web server:

        $ cd myapp
        $ rake load:sub_topics load:listens load:users
        $ rails server

   Run with `--help` or `-h` for options.

4. Using a browser, go to `http://localhost:3000`

5. Click on Recommendations under any sub topic for recommendations on that sub topic

## License

Ruby on Rails is released under the [MIT License](http://www.opensource.org/licenses/MIT).
