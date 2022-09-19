# MyFitnessPal Challenge

### Requirements
**Design and implement a simple chat service that must meet the following:**
1. Be ready for production deployment
1. Scale horizontally
1. Use HTTP
1.The service must be accessible via cURL
  1. provide step-by-step instructions
1.Handle at least 10 requests/second for reads and writes while adhering to the Api contract specified in the documentation

#### Tech Stack
* Ruby 3.1.2

* Rails 7.0.3.1

* PostgreSQL 14.5

* Heroku

#### Production Code
https://myfitnesspalchatbot.herokuapp.com/
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

# API cURL commands

You will need to update the id and username in the given examples.
If you would like to run this in production, update the url for the curl commands to be `http://myfitnesspalchatbot.herokuapp.com`:

## Create a new chat

### Request

`POST /chats`

```
curl -v \
  -H "Accept: application/json" \
  -H "Content-type: application/json" \
  -d ' {"chat":{"username":"FooBar123", "text":"That guy got hit in the head with 2 coconuts."}}' \
http://localhost:3000/chats
```
### Response
```
POST /chats HTTP/1.1
Content-type: application/json
Content-Length: 87
HTTP/1.1 201 Created

{"id":1}
```

## Get a list of all chats
### Request

`GET /chats`

```
curl -v \
  -H "Accept: application/json" \
  -H "Content-type: application/json" \
  -X GET \
  http://localhost:3000/chats
```
### Response
```
GET /chats HTTP/1.1
Content-type: application/json
HTTP/1.1 200 OK

{"username":"FooBar123","text":"That guy got hit in the head with 2 coconuts.","expiration_date":"2022-09-19T17:52:14.634Z","is_read":false}
```

## Get a chat by id
### Request

`GET /chats/:id`
```
curl http://localhost:3000/chats/1
```
### Response
```
{"username":"FooBar123","text":"That guy got hit in the head with 2 coconuts.","expiration_date":"2022-09-19T17:52:14.634Z","is_read":false}
```

## Get a chat by username
`GET /chats/user/:username`
### Request
```
curl http://localhost:3000/chats/user/FooBar123
```
### Response
```
[{"id":1,"text":"That guy got hit in the head with 2 coconuts.","is_read":false}]
```

## Update chat (example for is_read)
### Request
```
curl -v \
  -H "Accept: application/json" \
  -H "Content-type: application/json" \
  -X PUT \
  -d ' {"chat":{ "id":1, "is_read":true}}' \
http://localhost:3000/chats/1
```
### Response
```
[{"id":1,"text":"That guy got hit in the head with 2 coconuts.","is_read":true}]
```

## Delete a chat
### Request
```
curl -v \
  -H "Accept: application/json" \
  -H "Content-type: application/json" \
  -X DELETE \
  http://localhost:3000/chats/1
```
### Response
```
DELETE /chats/1 HTTP/1.1
Content-type: application/json
HTTP/1.1 204 No Content
```
___

## Follow Up Questions

Given your implementation, summarize how your solution could scale to millions of daily users and 1000 requests/second split evenly between reads and writes. Consider the following:

* Data persistence / caching
* Portability
* Scalability
* Testability
* Framework implementation details

## Additional things to consider:

* What questions might you have for product owners that could clarify or inform the need to scale your service? 
* What technologies would you pick? Why? 
* What would you keep in your service? What might you change? 
* How would you monitor your service? 
* How would you secure and protect your service? 
* What improvements would you recommend for future development of this service?


