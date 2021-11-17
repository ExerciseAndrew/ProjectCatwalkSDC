DROP DATABASE IF EXISTS questionsAndAnswers;

CREATE DATABASE questionsAndAnswers;

USE questionsAndAnswers;

CREATE TABLE questions (
    questionId INT NOT NULL,
    productId INT NOT NULL,
    body VARCHAR(1000),
    questionDate DATE,
    askerName VARCHAR(100),
    reported INT NOT NULL,
    questionHelpfulness INT NOT NULL,
    question_pkey PRIMARY KEY (questionId)
--    CONSTRAINT involving primary key question id
);

CREATE TABLE answers (
    answerID INT NOT NULL,
    questionID INT NOT NULL,
    body VARCHAR(1000),
    answerDate DATE,
    answererName VARCHAR(100),
    reported INT NOT NULL,
    answerHelpfulness INT NOT NULL,
    answer_pkey PRIMARY KEY (answerID)
    --    CONSTRAINT involving primary key question id if i switch to postgres

);

CREATE TABLE answerPhotos (
    photoID INT,
    answerID INT,
    URL VARCHAR(1000),
    CONSTRAINT answerPhotos_pkey PRIMARY KEY (photoID),
    CONSTRAINT answerID FOREIGN KEY (photoID)
    -- answerPhotos_pkey PRIMARY KEY (photoID),
    -- answerID FOREIGN KEY (photoID)
);

INSERT INTO questions (questionId, productId, body, date, askerName,  reported, questionHelpfulness) VALUES (1, 0, "What is a jumbus?", 10212011, "ReallyAsking", 0);
INSERT INTO answers (answerID, questionID, body, date, answererName, reported, answerHelpfulness) VALUES (1, 1, "You shouldnt ask about things you dont really want the answer to. - beware -", 10242011, "littleJazzMan", 0, 2);
INSERT INTO answers (answerID, questionID, body, date, answererName, reported, answerHelpfulness) VALUES (2, 1, "I tattooed a turkey with the answers you seek. It is in your car", 11202014, "Myster_E_usJumbus", 1, 0);
INSERT INTO answerPhotos (photoID, answerID, URL) VALUES (1, 2, "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfN43Dc8HEDz7xbZaY7JxhgTPZ2KnqleBDZA&usqp=CAU");


