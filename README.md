# MyFitnessPal Challenge

### Requirements
**Design and implement a simple chat service that must meet the following:**
1. Be ready for production deployment
1. Scale horizontally
1. Use HTTP
1. The service must be accessible via cURL
  1. provide step-by-step instructions
1. Handle at least 10 requests/second for reads and writes while adhering to the Api contract specified in the documentation

#### Tech Stack
* Ruby 3.1.2

* Rails 7.0.3.1

* PostgreSQL 14.5

* Heroku

#### Production Code
https://myfitnesspalchatbot.herokuapp.com/
___
# API cURL commands

You will need to update the id and username in the given examples.
If you would like to run this locally, you will need to update the url for the curl commands to be `http://localhost:3000`:

## Create a new chat
Creates a chat object with a default timeout/expiration date of 60 seconds.

`username` and `text` are required fields
### Request

`POST /chats`

```
curl -v \
  -H "Accept: application/json" \
  -H "Content-type: application/json" \
  -d ' {"chat":{"username":"FooBar123", "text":"That guy got hit in the head with 2 coconuts."}}' \
http://myfitnesspalchatbot.herokuapp.com/chats
```
### Response
```
HTTP/1.1 201 Created

{
   "id":1
}
```

## Get a list of all chats
Returns all chat messages reguardless of `expiration date` or `is_read`

Useful for testing and checking saved records 
### Request

`GET /chats`

```
curl -v http://myfitnesspalchatbot.herokuapp.com/chats
```
### Response
```
HTTP/1.1 200 OK

[
   {
      "id":1,
      "username":"FooBar123",
      "text":"That guy got hit in the head with 2 coconuts.",
      "expiration_date":"2022-09-19T17:52:14.634Z",
      "is_read":false
   }
]
```

## Get chat by id
Returns a specific chat by its `id` 

### Request

`GET /chats/:id`
```
curl -v http://myfitnesspalchatbot.herokuapp.com/chats/1
```
### Response
```
HTTP/1.1 200 OK

{
  "username":"FooBar123",
  "text":"That guy got hit in the head with 2 coconuts.",
  "expiration_date":"2022-09-19T17:52:14.634Z",
  "is_read":false
}
```

## Get chats by username
Returns a list of all unexpired and unread messages for a given `username`
### Request
`GET /chats/user/:username`
```
curl -v http://myfitnesspalchatbot.herokuapp.com/chats/user/FooBar123
```
### Response
```
HTTP/1.1 200 OK

[
   {
      "id":1,
      "text":"That guy got hit in the head with 2 coconuts.",
      "is_read":false
   }
]
```

## Update chat (example for is_read)
Updates a chat record given the id and new fields
### Request
`PUT /chats/:id`
```
curl -v \
  -H "Accept: application/json" \
  -H "Content-type: application/json" \
  -X PUT \
  -d ' {"chat":{ "id":1, "is_read":true}}' \
http://myfitnesspalchatbot.herokuapp.com/chats/1
```
### Response
```
HTTP/1.1 200 OK

{
   "id":1
}
```

## Delete a chat
Deletes a chat record given the id
### Request
`DELETE /chats/:id`
```
curl -v \
  -H "Accept: application/json" \
  -H "Content-type: application/json" \
  -X DELETE \
http://myfitnesspalchatbot.herokuapp.com/chats/1
```
### Response
```
HTTP/1.1 204 No Content
```

## Additional Notes
If a record cannot be found for any of the GET, PUT, or DELETE requests, the response will be a 404
```
HTTP/1.1 404 Not Found

{
   "status":404,
   "error":"Not Found"
}
```

If there is a validation error and a record cannot be created or updated, the response will be a 422 and will contain the fields with error messages
```
HTTP/1.1 422 Unprocessable Entity

{
   "username":[
      "can't be blank"
   ]
}
```
___
## Run code locally
_Helpful video: [Install Rails 7 on MacOS](https://www.youtube.com/watch?v=rg9DCX33IDY)_

#### Install Homebrew
[brew.sh](https://brew.sh/)
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### Install rvm
[rvm.io](https://rvm.io/)

```
\curl -sSL https://get.rvm.io | bash -s stable --rails
```

**Check to see ruby and rails are installed:**
```
ruby -v
```
###### ruby 3.1.2p20
```
rails -v
```
###### Rails 7.0.3.1

#### Install Yarn
[yarnpkg.com](https://yarnpkg.com/)

_You need nodejs installed for yarn:_
```
brew install node
```
```
brew install yarn
```

#### Install postgres
```
brew install postgresql
```
**Check to see postgres is installed:**
```
postgres --version
```
###### postgres (PostgreSQL) 14.5 (Homebrew)


#### Clone the project
```bash
  git clone https://github.com/Seaanna/myfitnesspal_chatbot.git
```
#### Install dependencies
```bash
  bundle
```
#### Load Database
```bash
 rake db:create
 rake db:migrate
```
#### Start the server
```bash
  rails s
```
#### Run Tests
```bash
 bin/rails test
```
___

## Follow Up Questions

### Given your implementation, summarize how your solution could scale to millions of daily users and 1000 requests/second split evenly between reads and writes. Consider the following:

**Data persistence/caching:**

All the data is saved in a Postgres database. Rails internally caches responses and database queries as needed. Additional caching can be configured in a Rails app, but you may want to hook up analytics to identify slow responses first.

Some links on caching APIs for Rails app
https://medium.com/@lizdenhup/boosting-your-rails-api-performance-through-caching-f68724b92bd5

https://engineering.wework.com/caching-external-apis-in-rails-for-a-ginormous-speed-boost-dd993f3a8cec

**Portability:**

The app is a typical Rails app and can be deployed using most services. I chose Heroku because it is specifically designed for Rails applications and is one of the easiest places to deploy. Heroku is basically a wrapper ontop of AWS that will hook up servers and DBs using their GUI interface.

To run the app locally, a user needs to have Ruby 3.1.2 installed on their machine. From there, they can install Rails and the other dependencies. Instructions are in the readme.

If more portability is needed, maybe a containerizing managament system like Docker or Kubernetes could be more helpful to easily deploy on different systems. Then you would be able to setup and deploy regardless of Windows, Mac, Linux, etc. You would still need to make sure your system is set up to use the containerizing system.


**Scalability:**

I used Heroku to deploy and scale horizontally. Each Heroku “dyno” is a server that can respond to requests. Each dyno can have multiple threads/workers. So a dyno with 3 workers can handle 3 requests concurrently.

It is easy to scale horizontally by increasing the number of dynos/servers. However, your configuration needs to be set up so there are enough resources for all the pieces to do their part. This means things like enough DB connections for workers and background jobs or enough RAM/memory (Rails apps can be memory hogs).


Heroku dynos can be configured to autoscale up and down as needed. This can be expensive so I would definitely ask if cost was going to be an issue or if there is a type of budget we would want to stick to.

More info on Heroku horizontal scaling
https://devcenter.heroku.com/articles/scaling


**Testability:**

There are a few model (unit) and controller tests set up for this service using Minitest. These tests make sure all the endpoints have the correct responses given the necessary params. The unit tests check things like the expiration_date logic and json serialization.

Most Rails applications use rspec instead of Minitest so I could add rspec for better readability and familiarity. Other than the actual tests inside the application, testing this service is fairly easy from the Readme docs. If a person wants to see the system work, they can run the cURL commands using the Heroku URL.

More info on Rails testing with Minitest
https://guides.rubyonrails.org/testing.html


**Framework implementation details:**

Ruby on Rails
PostgreSQL 14.5
Heroku

I used Ruby on Rails and postgres because it is what I know and have worked in the most. Heroku makes it really easy to deploy rails applications and I have mainly used that on Ruby on Rails projects.

I educated myself on Python and Java enough to know they are good options for the API. I was looking for comparisons and similarities to how things are done in Rails/Ruby vs Java or Python. However, for a simple API challenge like this, I think Rails is a great option and allowed me to show off what I know rather than just Googling lots of new topics/syntax for Java/Python. I would be interested in talking with the team and learning their approach to the framework/scalibility requirements.


