querystring = require 'querystring'
fs = require 'fs'
formidable = require 'formidable'

start = (res, req) ->
  console.log 'Request handler start was called.'
  body = '<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html;" charset="UTF-8"/>
    </head>
    <body>
    <form action="/upload" enctype="multipart/form-data" method="post">
    <input type="file" name="upload">
    <input type="submit" value="Upload File" />
    </form>
    </body>
    <html>'

  res.writeHead 200, 'Content-Type': 'text/html'
  res.write body
  res.end()

upload = (res, req) ->
  console.log 'Request handler upload was called.'

  form = new formidable.IncomingForm()
  console.log "about to parse"

  form.parse req, (error, fields, files) ->
    console.log 'paseing done'
    fs.rename files.upload.path, '/tmp/test.png', (err) ->
      fs.unlink '/tmp/test.png'
      fs.rename files.upload.path, '/tmp/test.png'

    res.writeHead 200, 'Content-Type':'text/html'
    res.write 'received image: <br/>'
    res.write '<img src="/show" />'
    res.end();

show = (res, req) ->
  console.log 'Request handler show was called'
  fs.readFile '/tmp/test.png', 'binary', (error, file) ->
    if error
      res.writeHead 500, 'Content-Type":"text/plain'
      res.write error + '\n'
      res.end();
    else
      res.writeHead 200, 'Content-Type':'image/png'
      res.write file, 'binary'
      res.end();

exports.start = start;
exports.upload = upload;
exports.show = show;