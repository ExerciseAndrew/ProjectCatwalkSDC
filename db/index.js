const { Pool } = require('pg');

const PORT = 5432;

const pool = new Pool({
  host: 'localhost',
  user: 'postgres',
  database: 'questionsandanswers',
  port: PORT,
  idleTimeoutMillis: 0,
  connectionTimeoutMillis: 0,
});

//acquires client from the pool.
//pool.query(callback: (err?: Error, result: pg.Result)) => void
pool.connect((err) => {
  if (err) {
    console.log('err', err);
  } else {
    console.log(`Connected to postgreSQL on port: ${PORT}`);
  }
});

//extract
const getQuestionsUnder5 = (callback) => {
  pool.query('SELECT * FROM questions WHERE questionId < 5', (err, results) => {
    if (err) {
      callback(err, null);
    } else {
      callback(null, results);
    }
  });
};

const getQuestionWithProductID = (productId, callback) => {
  pool.query(`SELECT
  questions.questionId,
  questions.body,
  questions.date,
  questions.askerName,
  questions.helpfullness,
  questions.reported,
  COALESCE (jsonb_object_agg(answers.answerId, jsonb_build_object(
  'id', answers.answerId,
  'body',answers.body,
  'date',answers.date,
  'answerName',answers.answerName,
  'helpfulness',answers.helpfulness,
  'photos', answers.photos))
  FILTER (WHERE answers.answerId IS NOT NULL), '{}') AS answers
  FROM questions LEFT JOIN answers ON (questions.questionId = answers.questionId)
  WHERE questions.productId = ${productId}
  AND questions.reported = false
  GROUP BY questions.questionId LIMIT 5;`, (err, results) => {
    if (err) {
      console.log(err);
      callback(err, null);
    } else {
      callback(null, results);
    }
  });
};

let currentQuestionId;
let page = 1;
let count = 5;
const getAnswers = (questionId, callback) => {
  if (currentQuestionId === undefined) {
    currentQuestionId = questionId;
  } else if (currentQuestionId === questionId) {
    page += 1;
    count += 5;
  } else {
    currentQuestionId = questionId;
    page = 1;
    count = 5;
  }
  if (count > 5) {
    pool.query(`SELECT * FROM answers WHERE questionID = ${questionId} AND reported = false OFFSET ${count}`, (err, results) => {
      results.page = page;
      results.count = count;
      if (err) {
        callback(err, null);
      } else {
        callback(null, results);
      }
    });
  } else {
    pool.query(`SELECT * FROM answers WHERE questionID = ${questionId} AND reported = false`, (err, results) => {
      results.page = page;
      results.count = count;
      if (err) {
        callback(err, null);
      } else {
        callback(null, results);
      }
    });
  }
};


//-------------------------------extract

//any tansforms would be made here.
//---------------------------------transform


//load
const addQuestion = (params, callback) => {
  pool.query('INSERT INTO questions (productId, body, date, askerName, askerEmail, reported, helpfullness) VALUES (?, ?, ?, ?, ?, ?, ?)',
    [params.productId,
      params.body,
      params.date,
      params.askerName,
      params.askerEmail,
      params.reported,
      params.helpfullness
    ], (err, results) => {
      if (err) {
        callback(err, null);
      } else {
        callback(null, results);
      }
    });
};

const addAnswer = (params, questionID, callback) => {
  pool.query('INSERT INTO answers("questionid", "body", "answername", "answeremail", "reported", "helpfulness", "photos") VALUES($1, $2, $3, $4, $5, $6, $7)',
    [
      questionID,
      params.body,
      params.askerName,
      params.askerEmail,
      params.reported,
      params.helpfulness,
      params.photos
    ], (err, results) => {
      if (err) {
        callback(err, null);
      } else {
        callback(null, results);
      }
    });
};

const changeQuestionHelpfulness = (questionID, callback) => {
  pool.query(`UPDATE questions SET helpfullness = helpfullness + 1 WHERE questionId = ${questionID}`, (err, results) => {
    if (err) {
      callback(err, null);
    } else {
      callback(null, results);
    }
  });
};

const reportQuestion = (questionID, callback) => {
  pool.query(`UPDATE questions SET reported = reported + 1 WHERE questionId = ${questionID}`, (err, results) => {
    if (err) {
      callback(err, null);
    } else {
      callback(null, results);
    }
  });
};

const changeAnswerHelpfulness = (answerID, callback) => {
  pool.query(`UPDATE answers SET helpfulness = helpfulness + 1 WHERE answerId = ${answerID}`, (err, results) => {
    if (err) {
      callback(err, null);
    } else {
      callback(null, results);
    }
  });
};

const reportAnswer = (answerID, callback) => {
  pool.query(`UPDATE answers SET reported = reported + 1 WHERE answerId = ${answerID}`, (err, results) => {
    if (err) {
      callback(err, null);
    } else {
      callback(null, results);
    }
  });
};


//---------------------------------load

module.exports = {
  getQuestionsUnder5, getQuestionWithProductID,
  addQuestion,
  getAnswers,
  addAnswer,
  changeQuestionHelpfulness,
  reportQuestion,
  changeAnswerHelpfulness,
  reportAnswer
};