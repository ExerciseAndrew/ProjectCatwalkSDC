-- head -5 questions.csv


CREATE DATABASE questionsAndAnswers;
SET SCHEMA 'questionsAndAnswers';
CREATE TABLE questions (
    questionId BIGSERIAL,
    productId BIGINT,
    body text,
    date BIGINT,
    askerName text,
    askerEmail text,
    reported BIGINT,
    helpfullness BIGINT,
    CONSTRAINT questions_pkey PRIMARY KEY (questionId)
);

CREATE TABLE answers (
    answerID BIGSERIAL,
    questionID BIGSERIAL,
    body text,
    date BIGINT,
    answerName text,
    answerEmail text,
    reported BIGINT,
    helpfulness BIGINT,
    CONSTRAINT answers_pkey PRIMARY KEY (answerID)
);

CREATE TABLE answerPhotos (
    photoID BIGSERIAL,
    answerID BIGSERIAL,
    URL text,
    CONSTRAINT answerPhotos_pkey PRIMARY KEY (photoID),
    CONSTRAINT answerID FOREIGN KEY (photoID)
        REFERENCES answers (answerID) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

