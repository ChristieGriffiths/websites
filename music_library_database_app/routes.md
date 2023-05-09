# {{ METHOD }} {{ PATH}} Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature

 
You'll need to include:
  * the HTTP method: GET 
  * the path: artists 
  * body parameters: -

You'll need to include:
  * the HTTP method: POST
  * the path: artists 
  * body parameters: name: 'Wild nothing' genre: indie

## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```
1st Test => returns list of artists' names.
            Also returns a 200 status.

2nd Test => creates a new artist and we prove this by calling the all method and it should return the new list of artists including our added artist.  
            Also returns a 200 status.


```

## 3. Write Examples

_Replace these with your own design._

```
# Request:

GET /artists

# Expected response:

Pixies
Abba
Taylor Swift
Nina Simone
Kiasmos

Response for 200 OK
```

```
# Request:

POST /create

# Expected response:
Returns nothing.
Response for 200 OK

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /" do
    it 'returns 200 OK' do
      # Assuming the post with id 1 exists.
      response = get('/posts?id=1')

      expect(response.status).to eq(200)
      # expect(response.body).to eq(expected_response)
    end

    it 'returns 404 Not Found' do
      response = get('/posts?id=276278')

      expect(response.status).to eq(404)
      # expect(response.body).to eq(expected_response)
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.

