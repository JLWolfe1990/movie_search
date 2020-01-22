## Up and Running

1) `rails db:create db:migrate`
2) Copy `.env.example` to `.env` if you want to use the provided keys
3) `rails s`

## Example Command

### Development

`curl -X GET "http://localhost:3000/api/v1/searches" -H 'Content-Type: application/json' -d '{"query": "bob"}'`

`curl -X GET "http://localhost:3000/api/v1/searches" -H 'Content-Type: application/json' -d '{"query": "Harry Potter"}'`

### Production 

`curl -X GET "http://movie-search-jwolfe.herokuapp.com/api/v1/searches" -H 'Content-Type: application/json' -d '{"query": "Harry Potter"}'`

## Notable Design Decisions

I decided to cache the same requests. This means that the data will get stale eventually. Therefore,
I decided to time it out every day. That seemed like a reasonable timeframe to reload movie data.
