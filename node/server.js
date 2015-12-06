var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var Parse = require('parse/node').Parse;
var time = require('time');
var CronJob = require('cron').CronJob;
var request = require("request");
var Browser = require("zombie");
var cheerio = require("cheerio");

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

        var json;
        var browser = new Browser();

        browser.visit("https://www.managebgl.com/login.html", function() {
            console.log(browser.location.href);

            browser
                .fill('email', 'phil.efstat@gmail.com')
                .fill('password', 'tc2015')
                .pressButton('Log in');
            });


            browser.wait().then(function() {
                console.log('Form submitted ok!');
                // the resulting page will be displayed in your default browser
                setTimeout(function() {
                    browser.visit("https://www.managebgl.com/home.html", function() {
                        var page = browser.resources[0].response.body;
                        $ = cheerio.load(page);

//                        console.log(page.indexOf("var bgl_estimates ="));

                        var index1 = page.indexOf("var bgl_estimates =");
                        var index2 = page.indexOf(";", index1);
                        console.log(index1);
                        console.log(index2);
                        res.send(JSON.parse(JSON.stringify(page.substring(index1 + 28, index2))));
                    });


                }, 1000);
            });
    });

router.route('/estimate')
    .get(function(req, res) {
        res.send(200);
    });

router.route('/log')
    .post(function (req, res) {

        var input = JSON.parse(req);

        request("https://www.ManageBGL.com/api/1.0/login.json?email=phil.efstat@gmail.com&password=tc2015", function(error, response, body) {
            var data = JSON.parse(body);
            console.log(data);
            console.log("token",data.token);
            var url = "https://www.ManageBGL.com/api/1.0/add.json?token=" + data.token;
            url += "&logtype=" + input.type;
            url += "&value=" + input.value;
            url += "&time=" + input.time;
            //&log_type=1&value=4.6&time=2015-12-05 16:00:03"
            request(url, function(error, response, body) {
                console.log("body",body);
                if (error) {
                    console.log(error);
                    res.send(400);
                } else {
                    res.send(200);
                }
            });
        });
    });



app.use('/', router);
app.listen(port);
console.log("We're live on port " + port);
