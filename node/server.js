var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var Parse = require('parse/node').Parse;
var time = require('time');
var CronJob = require('cron').CronJob;
var request = require("request");

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

router.route('log')
    .post(function (req, res) {

        var url = "https://www.ManageBGL.com/api/1.0/add.json?token=5006--5046b4aceaa70c2b5068427e8e79d07a"

        url.append("&logtype=" + req.body.type);
        url.append("&value=" + req.body.value);
        url.append("&time=" + req.body.time);
        //&log_type=1&value=4.6&time=2015-12-05 16:00:03"

        request(url, function(error, response, body) {
            console.log(body);
            if (error) {
                console.log(error);
                res.send(400);
            } else {
                res.send(200);
            }
        });
    });


app.use('/', router);
app.listen(port);
console.log("We're live on port " + port);
