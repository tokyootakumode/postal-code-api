const express = require("express");
const morgan = require("morgan");
const log4js = require("log4js");
const logger = log4js.getLogger();
logger.level = "debug";

// Constants
const PORT = 3000;

// App
const app = express();

app.use(morgan("combined"));

app.all("/", function (req, res) {
  res.sendFile(`${__dirname}/lib/example/index.html`);
});

app.all("/api/v1/:first/:second", function (req, res) {
  res.json(
    require(`${__dirname}/api/v1/${req.params.first}/${req.params.second}`)
  );
});

app.listen(PORT, "0.0.0.0");
logger.debug("Running on http://0.0.0.0:" + PORT);
