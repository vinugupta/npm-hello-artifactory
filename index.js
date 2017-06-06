// requiring the HTTP interfaces in node
var http = require('http');

// create an http server to handle requests and response
http.createServer(function (req, res) {

	// sending a response header of 200 OK
	res.writeHead(200, {'Content-Type': 'text/plain'});

	// print out Hello World
	res.end('Hello World\n');
	const buf = new Buffer(10);
        res.end('buf.fill(0)');
        console.log('buffer: ' + buf.fill(0) );
	
// use port 8888
}).listen(8888);
console.log('Server running on port 8888.');
