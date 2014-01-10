var express = require('express');
var app = express();

app.get('/', function(request, response) {
    response.send("This would be some HTML");
});

app.get('/app/hello', function(request, response) {
    kanbanApp = {
        uri: "localhost:3000/repo/hello/index.html"
    }
    response.contentType = 'application/json';

    response.send( kanbanApp );
});

app.use(express.static(__dirname));

app.listen(3000);