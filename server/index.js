const express = require('express');
const path = require('path');
const bodyParser = require('body-parser');
const db = require('../db/index');

const app = express();
const PORT = 3000;

app.use(express.static(path.join(__dirname, '/../client/dist')));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.listen(PORT, () => {
  console.log(`Listening to port: ${PORT}`);
});

// app.get('/api/qa/questions', (req, res) => {
//   db.getQuestionsUnder5((err, results) => {
//     if (err) {
//       res.status(400).send(err);
//     } else {
//       res.status(200).send(results);
//     }
//   });
// });

app.get('/api/qa/questions', (req, res) => {
  db.getQuestionWithProductID(req.body.productId, (err, results) => {
    if (err) {
      res.status(400).send(err);
    } else {
      res.status(200).send({
        product_id: req.body.productId,
        results: results.rows
      });
    }
  });
});

app.get('/api/qa/questions/:question_id/answers', (req, res) => {
  const questionId = req.params.question_id;
  db.getAnswers(questionId, (err, results) => {
    if (err) {
      res.status(400).send(err);
    } else {
      res.status(200).send({
        question: questionId,
        page: results.page,
        count: results.count,
        results: results.rows
      });
    }
  });
});

app.post('/api/qa/questions', (req, res) => {
  db.addQuestion(req.body, (err, results) => {
    if (err) {
      res.status(400).send(err);
    } else {
      res.status(201).send(results);
    }
  });
});

app.post('/api/qa/questions/:question_id/answers', (req, res) => {
  db.addAnswer(req.body, req.params.question_id, (err, results) => {
    if (err) {
      res.status(400).send(err);
    } else {
      res.status(201).send(results);
    }
  });
});

app.put('/api/qa/questions/:question_id/helpful', (req, res) => {
  db.changeQuestionHelpfulness(req.params.question_id, (err, results) => {
    if (err) {
      res.status(400).send(err);
    } else {
      res.status(204).send(results);
    }
  });
});

app.put('/api/qa/answers/:answer_id/helpful', (req, res) => {
  db.changeAnswerHelpfulness(req.params.answer_id, (err, results) => {
    if (err) {
      res.status(400).send(err);
    } else {
      res.status(204).send(results);
    }
  });
});

app.put('/api/qa/questions/:question_id/report', (req, res) => {
  db.reportQuestion(req.params.question_id, (err, results) => {
    if (err) {
      res.status(400).send(err);
    } else {
      res.status(204).send(results);
    }
  });
});

app.put('/api/qa/answers/:answer_id/report', (req, res) => {
  db.reportAnswer(req.params.answer_id, (err, results) => {
    if (err) {
      res.status(400).send(err);
    } else {
      res.status(204).send(results);
    }
  });
});