const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const db = require('../postgreSQLdb/index');

const app = express();
const PORT = 3000;

app.use(express.static(path.join(__dirname, '/../client/dist')));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.listen(PORT, () => {
  console.log(`Listening to port: ${PORT}`);
});

app.get('/api/qa/questions', (req, res) => {
  db.getQuestionsUnder5((err, results) => {
    if (err) {
      res.status(400).send(err);
    } else {
      res.status(200).send(results);
    }
  });
});

app.post('/api/qa/questions', (req, res) => {
  db.addQuestion(req.body, (err, results) => {
    if (err) {
      res.status(400).send(err);
    } else {
      res.status(200).send(results);
    }
  });
});