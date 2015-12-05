var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var Parse = require('parse/node').Parse;
var time = require('time');
var CronJob = require('cron').CronJob;

Parse.initialize("Z6odwa0AvOCTGRd72nNeDmULJiqiEawl4bxWUfwV", "tbDlnN9RK8lbMaxjmQ3ZHLwrgZjHk6eouZEzqOY7");

var port = process.env.PORT || 3000;

app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

var router = express.Router();

router.get('/test', function(req, res) {
    res.json({ message: 'this is the api' });
});

router.route('/')
    .get(function(req, res) {
        res.send(200);
    });

router.route('/data')
    .post(function(req, res) {
        var data = req.body;

        var type = data.type;
        var value = data.value;
    });

router.route('/graph')
    .get(function(req, res) {
        res.send(200);
    });

router.route('/estimate')
    .get(function(req, res) {
        res.send(200);
    });


app.use('/', router);
app.listen(port);
console.log("We're live on port " + port);
