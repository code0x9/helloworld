const port = 8080
const version = 27
let http = require('http')

http.createServer(function(request, response) {
    console.log(`${new Date().toISOString()} ${request.connection.remoteAddress} ${request.url} `)
    response.end(`Hello World! version:${version}\n`)
}).listen(port)

console.log(`listening on port ${port}`)
