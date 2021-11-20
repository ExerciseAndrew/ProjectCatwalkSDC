const { Pool } = require('pg');

const PORT = 3000;

const pool = new Pool({
  host: 'localhost',
  user: 'database-user',
  database: 'questionsandanswers',
  port: PORT
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

const getQuestionsUnder5 = (callback) => {
  pool.query('SELECT * FROM questions WHERE questionId < 5', (err, results) => {
    if (err) {
      callback(err, null);
    } else {
      callback(null, results);
    }
  });
};

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

module.exports = {
  getQuestionsUnder5, addQuestion
};