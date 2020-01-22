## Up and Running

`rails db:create db:migrate`
`rails s`

## Example Command

`curl -X GET "http://localhost:3000/api/v1/searches" -H 'Content-Type: application/json' -d '{"query": "bob"}'`

`curl -X GET "http://localhost:3000/api/v1/searches" -H 'Content-Type: application/json' -d '{"query": "Harry Potter"}'`

## Notable Design Decisions

I decided to cache the same requests. This means that the data will get stale eventually. Therefore,
I decided to time it out every day. That seemed like a reasonable timeframe to reload movie data.
