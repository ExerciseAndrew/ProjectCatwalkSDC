const mongoose = require ('mongoose');

const answerPhotosTable = new mongoose.Schema(
  {
    photoId: Number,
    url: String
  },
  { _id: false }
);

const answersTable = new mongoose.Schema(
  {
    answerId: Number,
    text: String,
    name: String,
    email: String,
    reported: Boolean,
    helpful: Number,
    photos: [answerPhotosTable]
  },
  { _id: false }
);

const questionsTable = new mongoose.Schema(
  {
    questionId: Number,
    dateWritten: Date,
    text: String,
    name: String,
    email: String,
    reported: Boolean,
    helpful: Number,
    answers: [answersTable]
  },
  { _id: false }
);

const qASchema = new mongoose.Schema({
  productId: Number,
  questions: [questionsTable]
});

const 

module.exports = {

};