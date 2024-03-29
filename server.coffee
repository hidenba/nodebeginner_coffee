http = require "http"
url = require "url"

start = (route, handle) ->
  onRequest = (request, response) ->
    postData = ''
    pathname = url.parse(request.url).pathname
    console.log "Request for " + pathname + " received."
    route handle, pathname, response, request

  http.createServer(onRequest).listen 8888
  console.log "Server has started"

exports.start = start;