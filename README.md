# MyFitnessPal Challenge
### Requirements
Design and implement a simple chat service that must meet the following:
1. Be ready for production deployment
2. Scale horizontally
3. Use HTTP
4. The service must be accessible via cURL
    - provide step-by-step instructions
5. Handle at least 10 requests/second for reads and writes while adhering to the Api contract specified in the documentation

#### Tech Stack
Ruby 3.1.2

Rails 7.0.3.1

Heroku


#### Production Code
https://myfitnesspalchatbot.herokuapp.com/
___
### Run code locally
Install rvm


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
### Example cURL commands

You will need to update the id and username in the given examples
If you are running this locally, please update url for the curl commands to be `http://localhost:3000/` instead of `http://myfitnesspalchatbot.herokuapp.com/`:

##### Create chat
```
curl -v \
  -H "Accept: application/json" \
  -H "Content-type: application/json" \
  -X POST \
  -d ' {"chat":{"username":"sea123", "text":"That guy got hit in the head with 2 coconuts."}}' \
 http://myfitnesspalchatbot.herokuapp.com/chats
```

##### GET all chats
```
curl -v \
  -H "Accept: application/json" \
  -H "Content-type: application/json" \
  -X GET \
  http://myfitnesspalchatbot.herokuapp.com/chats
```

##### GET chat by id
```
curl http://myfitnesspalchatbot.herokuapp.com/chats/1
```

##### GET chat by username
```
curl http://myfitnesspalchatbot.herokuapp.com/chats/user/sea123
```

##### Update chat example:
```
curl -v \
  -H "Accept: application/json" \
  -H "Content-type: application/json" \
  -X PUT \
  -d ' {"chat":{ "id":1, "is_read":true}}' \
http://myfitnesspalchatbot.herokuapp.com/chats/1
```

##### Delete a chat
```
curl -v \
  -H "Accept: application/json" \
  -H "Content-type: application/json" \
  -X DELETE \
  http://myfitnesspalchatbot.herokuapp.com/chats/1
```
___