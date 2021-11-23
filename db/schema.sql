-- head -5 questions.csv
-- pg_ctl -D /usr/local/var/postgres start
-- pg_ctl -D /usr/local/var/postgres stop
-- brew services start postgresql
--  \c questionsAndAnswers ---> put in load file
DROP DATABASE IF EXISTS questionsandanswers;
CREATE DATABASE questionsandanswers;
-- SET SCHEMA 'questionsAndAnswers';
DROP TABLE IF EXISTS questions;
CREATE TABLE questions (
    questionId INT,
    productId INT,
    body text,
    date BIGINT,
    askerName text,
    askerEmail text,
    reported BIGINT,
    helpfullness BIGINT,
    CONSTRAINT questions_pkey PRIMARY KEY (questionId)
);
DROP TABLE IF EXISTS answers CASCADE;
CREATE TABLE answers (
    answerID INT,
    questionID INT,
    body text,
    date BIGINT,
    answerName text,
    answerEmail text,
    reported BIGINT,
    helpfulness BIGINT,
    CONSTRAINT answers_pkey PRIMARY KEY (answerID)
);

DROP TABLE IF EXISTS answerPhotos CASCADE;
CREATE TABLE answerPhotos (
    photoID INT,
    answerID INT,
    URL text,
    CONSTRAINT answerPhotos_pkey PRIMARY KEY (photoID),
    CONSTRAINT answerID FOREIGN KEY (photoID)
        REFERENCES answers (answerID) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- WITH (FORMAT CSV, DELIMITER ',', HEADER);
-- ALTER TABLE features ADD FOREIGN KEY (product_id) REFERENCES products (id);


COPY questions FROM '/Users/liljazzman/HR138/ProjectCatwalkSDC/questions.csv' WITH DELIMITER ',' CSV HEADER;
COPY answers FROM '/Users/liljazzman/HR138/ProjectCatwalkSDC/answers.csv' WITH DELIMITER ',' CSV HEADER;
COPY answerPhotos FROM '/Users/liljazzman/HR138/ProjectCatwalkSDC/answers_photos.csv' WITH DELIMITER ',' CSV HEADER;











-- CREATE DATABASE questionsAndAnswers
--     WITH
--     OWNER = postgres
-- CREATE TABLE questions (
--     questionId SERIAL PRIMARY KEY,
--     productId BIGINT,
--     body text,
--     date BIGINT,
--     askerName text,
--     askerEmail text,
--     reported BIGINT,
--     helpfullness BIGINT
-- );
-- CREATE TABLE answers (
--     answerId SERIAL PRIMARY KEY,
--     questionID BIGSERIAL,
--     body text,
--     date BIGINT,
--     answerName text,
--     answerEmail text,
--     reported BIGINT,
--     helpfulness BIGINT,
--     photos TEXT[] NOT NULL DEFAULT ARRAY[]::TEXT[]
-- );
-- CREATE TABLE answerPhotos (
--     photoID BIGSERIAL,
--     answerID BIGSERIAL,
--     URL text,
--     CONSTRAINT answerPhotos_pkey PRIMARY KEY (photoID),
--     CONSTRAINT answerID FOREIGN KEY (photoID)
--         REFERENCES answers (answerID) MATCH SIMPLE
--         ON UPDATE NO ACTION
--         ON DELETE NO ACTION
-- );


