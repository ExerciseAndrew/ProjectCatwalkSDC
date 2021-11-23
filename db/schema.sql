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

-- >>>>>>

-- COPY questions FROM '/Users/liljazzman/HR138/ProjectCatwalkSDC/questions.csv' WITH DELIMITER ',' CSV HEADER;
-- COPY answers FROM '/Users/liljazzman/HR138/ProjectCatwalkSDC/answers.csv' WITH DELIMITER ',' CSV HEADER;
-- COPY answerPhotos FROM '/Users/liljazzman/HR138/ProjectCatwalkSDC/answers_photos.csv' WITH DELIMITER ',' CSV HEADER;

-- Changing date to be timestamps and default to create timestamps of current time
-- ALTER TABLE  questions
--   ALTER COLUMN date TYPE TIMESTAMP USING to_timestamp(date / 1000) + ((date % 1000) || ' milliseconds') :: INTERVAL;

-- ALTER TABLE  questions
--   ALTER COLUMN date SET DEFAULT now();

-- >>>>>>

-- Changing answers to have photos column and then seed those columns with the correct photos
-- Add photos column set it to an array, give it default as well
-- ALTER TABLE answers ADD photos TEXT[] NOT NULL DEFAULT ARRAY[]::TEXT[];

-- Create temp table that will be used for sorting photos by answerID
-- CREATE TEMP TABLE urls AS SELECT answerID, array_agg(url) as url_list FROM answerPhotos GROUP BY answerID;

-- Update answertable so that the photos array of each answer has the right answers
-- UPDATE answers SET photos = url_list FROM urls WHERE answers.answerId = urls.answerID;

-- >>>>>>>>>>

-- Creates user with all permissions
-- CREATE USER qauser WITH PASSWORD '12345';
-- GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO qauser;
-- GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO qauser;

-- Indexes
-- CREATE INDEX productId_questions_idx ON questions (productId);
-- CREATE INDEX reported_questions__idx ON questions (reported);
-- CREATE INDEX questionId_answers_idx ON answers (questionId);


-- wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1TbhRZ_sKBAu2Z0-sppE55D051G3MVP9I' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1TbhRZ_sKBAu2Z0-sppE55D051G3MVP9I" -O answer_photos.csv && rm -rf /tmp/cookies.txt
-- wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1yvXuqx6gT1ugD3vbVh6_tH8xEGx3Cwlb' -O questions.csv
-- wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1TbhRZ_sKBAu2Z0-sppE55D051G3MVP9I' -O answers_photos.csv
-- wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1xVnfJGxq0If2d3rJI1IUWTC1RLigik1l' -O answers.csv
